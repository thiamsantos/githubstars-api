defmodule Githubstars.Repos.Save do
  @moduledoc """
  Saves multiples repositories associating it with the given user.
  """
  use Githubstars.Service

  alias Githubstars.Repos.{Mutator, Loader}
  alias Githubstars.Tags.Mutator, as: TagsMutator
  alias Githubstars.Repos.Save.Params
  alias Githubstars.Core.{ErrorHandler, EctoUtils}

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         :ok <- save(request.repositories, request.user_id) do
      {:ok, request.repositories}
    else
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end

  defp save(repositories, user_id) do
    repositories
    |> Enum.map(&get_repo_id/1)
    |> initiate_tags(user_id)
    |> Enum.find(:ok, &find_errors/1)
  end

  defp get_repo_id(repo) do
    case Loader.get_repo_id_by_github_id(repo.github_id) do
      {:ok, id} -> {:ok, id}
      {:error, :repo_not_found} -> create_repo_returning_id(repo)
    end
  end

  defp create_repo_returning_id(repo) do
    with {:ok, repository} <- Mutator.create(repo) do
      {:ok, repository.id}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp initiate_tags(repositories_ids, user_id) do
    repositories_ids
    |> Enum.map(fn params ->
      case params do
        {:ok, repo_id} -> TagsMutator.initiate_tag_groups(repo_id, user_id)
        {:error, reason} -> {:error, reason}
      end
    end)
  end

  defp find_errors({:error, _reason}), do: true
  defp find_errors({:ok, _value}), do: false
end
