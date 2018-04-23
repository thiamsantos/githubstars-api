defmodule Githubstars.Repos.Loader do
  @moduledoc """
  Database data loading.
  """
  alias Githubstars.Repo
  alias Githubstars.Repos.Queries

  def all_by_user_id(params) do
    current_page = Map.get(params, :page, 1)
    page_size = Map.get(params, :page_size, 30)
    tag = Map.get(params, :tag)

    params.user_id
    |> build_all_query(tag)
    |> Repo.paginate(page: current_page, page_size: page_size)
  end

  defp build_all_query(user_id, tag) when is_nil(tag) do
    user_id
    |> Queries.all_by_user_id()
  end

  defp build_all_query(user_id, tag) do
    user_id
    |> Queries.all_by_user_id_and_tag(tag)
  end

  def one_by_id(%{user_id: user_id, id: id}) do
    user_id
    |> Queries.one_by_id(id)
    |> Repo.one()
    |> handle_one_by_id()
  end

  defp handle_one_by_id(nil), do: {:error, :repo_not_found}
  defp handle_one_by_id(repo), do: {:ok, repo}

  def get_repo_id_by_github_id(github_id) do
    github_id
    |> Queries.one_by_github_id()
    |> Repo.one()
    |> handle_get_repo_id_by_github_id()
  end

  defp handle_get_repo_id_by_github_id(nil), do: {:error, :repo_not_found}
  defp handle_get_repo_id_by_github_id(repo), do: {:ok, repo.id}
end
