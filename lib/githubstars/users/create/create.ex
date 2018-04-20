defmodule Githubstars.Users.Create do
  @moduledoc """
  Create an user and save the starred repos.
  """
  use Githubstars.Service

  alias Githubstars.Repos.Mutator, as: ReposMutator
  alias Githubstars.Tags.Mutator, as: TagsMutator
  alias Githubstars.Repos.Loader, as: ReposLoader
  alias Githubstars.Users.Mutator
  alias Githubstars.Users.Create.Params
  alias Githubstars.Core.{ErrorHandler, ErrorMessage, EctoUtils}

  @github_client Application.get_env(:githubstars, :github_client)

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, true} <- user_exists?(request.name),
         {:ok, user} <- Mutator.create(request),
         :ok <- save_repos(user.name, user.id) do
      {:ok, user}
    else
      {:error, :username_not_found} -> ErrorMessage.not_found("username not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end

  def user_exists?(username) do
    case @github_client.head("/users/#{username}") do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        {:ok, true}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :username_not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp save_repos(username, user_id) do
    do_save_repos("/users/#{username}/starred", user_id)
  end

  defp do_save_repos(url, user_id) do
    with {:ok, %{body: body, headers: headers}} <- get_paged_starred_repos(url),
         :ok <- parse_and_insert_repos(body, user_id) do
      case get_next_url(headers) do
        {:ok, :last_page} -> :ok
        {:ok, url} -> do_save_repos(url, user_id)
      end
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_next_url(headers) do
    case ExLinkHeader.parse(Map.get(Map.new(headers), "Link", "")) do
      {:ok, link_header} -> parse_link_header(link_header)
      :error -> {:ok, :last_page}
    end
  end

  def parse_link_header(link_header) do
    case Map.get(link_header, :next) do
      nil -> {:ok, :last_page}
      next_url -> {:ok, parse_next_link_url(next_url)}
    end
  end

  def parse_next_link_url(next_url) do
    "#{next_url.path}?#{URI.encode_query(next_url.params)}"
  end

  defp parse_and_insert_repos(body, user_id) do
    repos = parse_body(body)

    repos
    |> Enum.map(&get_repo_id/1)
    |> initiate_tags(user_id)
    |> Enum.find(:ok, &find_errors/1)
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

  defp find_errors({:error, _reason}), do: true
  defp find_errors({:ok, _value}), do: false

  defp get_repo_id(repo) do
    case ReposLoader.get_repo_id_by_github_id(repo.github_id) do
      {:ok, id} -> {:ok, id}
      {:error, :repo_not_found} -> create_repo_returning_id(repo)
    end
  end

  defp initiate_tags(repos, user_id) do
    repos
    |> Enum.map(fn params ->
      case params do
        {:ok, repo_id} -> TagsMutator.initiate_tag_groups(repo_id, user_id)
        {:error, reason} -> {:error, reason}
      end
    end)
  end

  defp create_repo_returning_id(repo) do
    with {:ok, repository} <- ReposMutator.create(repo) do
      {:ok, repository.id}
    else
      {:error, reason} -> {:error, reason}
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
