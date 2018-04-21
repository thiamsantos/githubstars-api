defmodule Githubstars.Users.Create.SaveRepos do
  @moduledoc """
  Save the starred repos of a given user on the database.
  """
  alias Githubstars.Repos
  alias Githubstars.Users.Create.NextUrl

  @github_client Application.get_env(:githubstars, :github_client)

  def save(username, user_id) do
    get_starred_repos_and_save("/users/#{username}/starred", user_id)
  end

  defp get_starred_repos_and_save(url, user_id) do
    with {:ok, %{body: body, headers: headers}} <- get_paged_starred_repos(url),
         {:ok, _repos} <- Repos.save(build_save_params(body, user_id)) do
      case NextUrl.next_url(headers) do
        {:ok, :last_page} -> :ok
        {:ok, url} -> get_starred_repos_and_save(url, user_id)
      end
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp build_save_params(body, user_id) do
    %{repositories: parse_body(body), user_id: user_id}
  end

  defp get_paged_starred_repos(url) do
    case @github_client.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}} ->
        {:ok, %{body: body, headers: headers}}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :username_not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_body(body) do
    body
    |> Jason.decode!()
    |> Enum.map(&cherrypick_keys/1)
  end

  defp cherrypick_keys(repo) do
    %{
      description: repo["description"],
      github_id: repo["id"],
      language: repo["language"],
      name: repo["name"],
      url: repo["html_url"]
    }
  end
end
