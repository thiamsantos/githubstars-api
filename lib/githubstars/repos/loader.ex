defmodule Githubstars.Repos.Loader do
  @moduledoc """
  Database data loading.
  """
  alias Githubstars.Repo
  alias Githubstars.Repos.Queries

  def get_repo_id_by_github_id(github_id) do
    github_id
    |> Queries.one_by_github_id()
    |> Repo.one()
    |> handle_get_repo_id_by_github_id()
  end

  defp handle_get_repo_id_by_github_id(nil), do: {:error, :repo_not_found}
  defp handle_get_repo_id_by_github_id(repo), do: {:ok, repo.id}
end