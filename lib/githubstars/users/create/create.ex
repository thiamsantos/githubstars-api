defmodule Githubstars.Users.Create do
  @moduledoc """
  Create an user and save the starred repos.
  """
  use Githubstars.Service

  alias Githubstars.Repos.Mutator, as: ReposMutator
  alias Githubstars.Repos.Loader, as: ReposLoader
  alias Githubstars.Users.Mutator
  alias Githubstars.Users.Create.Params
  alias Githubstars.Core.{ErrorHandler, ErrorMessage, EctoUtils}

  @github_client Application.get_env(:githubstars, :github_client)

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, body} <- get_starred_repos(request.name),
         {:ok, user} <- Mutator.create(request),
         :ok <- save_repos(body, user.id) do
      {:ok, user}
    else
      {:error, :username_not_found} -> ErrorMessage.not_found("username not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end

  defp get_starred_repos(username) do
    case @github_client.get("/users/#{username}/starred") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :username_not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp save_repos(body, user_id) do
    repos = parse_body(body)

    repos
    |> Enum.map(&get_repo_id/1)
    |> initiate_tags(user_id)
    |> Enum.find(:ok, &find_errors/1)
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
        {:ok, repo_id} -> ReposMutator.initiate_tag_groups(repo_id, user_id)
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
