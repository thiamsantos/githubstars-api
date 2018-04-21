defmodule Githubstars.Tags.Loader do
  @moduledoc """
  Load from database.
  """
  alias Githubstars.Repo
  alias Githubstars.Tags.Queries

  def get_tags(%{user_id: user_id, repository_id: repository_id}) do
    user_id
    |> Queries.tags_by_user_and_repository(repository_id)
    |> Repo.one()
    |> handle_get_tags()
  end

  defp handle_get_tags(nil), do: {:error, :tags_not_found}
  defp handle_get_tags(tags), do: {:ok, tags}

  def get_tag_group(user_id, repository_id) do
    user_id
    |> Queries.one_tag_group(repository_id)
    |> Repo.one()
    |> handle_get_tag_group()
  end

  defp handle_get_tag_group(nil), do: {:error, :tag_group_not_found}
  defp handle_get_tag_group(tag_group), do: {:ok, tag_group}
end
