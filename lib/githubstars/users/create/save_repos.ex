defmodule Githubstars.Users.Create.SaveRepos do
  @moduledoc """
  Save the starred repos of a given user on the database.
  """
  alias Githubstars.Repos.Mutator, as: ReposMutator
  alias Githubstars.Tags.Mutator, as: TagsMutator
  alias Githubstars.Repos.Loader, as: ReposLoader
  alias Githubstars.Users.Mutator

  @github_client Application.get_env(:githubstars, :github_client)

  def save(username, user_id) do
    get_starred_repos_and_save("/users/#{username}/starred", user_id)
  end

  defp get_starred_repos_and_save(url, user_id) do
    with {:ok, %{body: body, headers: headers}} <- get_paged_starred_repos(url),
         :ok <- parse_and_insert_repos(body, user_id) do
      case get_next_url(headers) do
        {:ok, :last_page} -> :ok
        {:ok, url} -> get_starred_repos_and_save(url, user_id)
      end
    else
      {:error, reason} -> {:error, reason}
    end
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

  defp parse_and_insert_repos(body, user_id) do
    repositories = parse_body(body)

    repositories
    |> Enum.map(&get_repo_id/1)
    |> initiate_tags(user_id)
    |> Enum.find(:ok, &find_errors/1)
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

  defp get_repo_id(repo) do
    case ReposLoader.get_repo_id_by_github_id(repo.github_id) do
      {:ok, id} -> {:ok, id}
      {:error, :repo_not_found} -> create_repo_returning_id(repo)
    end
  end

  defp create_repo_returning_id(repo) do
    with {:ok, repository} <- ReposMutator.create(repo) do
      {:ok, repository.id}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp initiate_tags(repositories, user_id) do
    repositories
    |> Enum.map(fn params ->
      case params do
        {:ok, repo_id} -> TagsMutator.initiate_tag_groups(repo_id, user_id)
        {:error, reason} -> {:error, reason}
      end
    end)
  end

  defp find_errors({:error, _reason}), do: true
  defp find_errors({:ok, _value}), do: false

  defp get_next_url(headers) do
    case ExLinkHeader.parse(Map.get(Map.new(headers), "Link", "")) do
      {:ok, link_header} -> parse_link_header(link_header)
      :error -> {:ok, :last_page}
    end
  end

  defp parse_link_header(link_header) do
    case Map.get(link_header, :next) do
      nil -> {:ok, :last_page}
      next_url -> {:ok, parse_next_link_url(next_url)}
    end
  end

  defp parse_next_link_url(next_url) do
    "#{next_url.path}?#{URI.encode_query(next_url.params)}"
  end
end
