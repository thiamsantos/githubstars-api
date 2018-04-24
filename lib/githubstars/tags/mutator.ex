defmodule Githubstars.Tags.Mutator do
  @moduledoc """
  Database mutations involving the tags_groups table.
  """
  alias Githubstars.Repo
  alias Githubstars.Tags.{TagGroup, Loader}

  def initiate_tag_groups(repository_id, user_id) do
    attrs = %{repository_id: repository_id, user_id: user_id, tags: []}

    %TagGroup{}
    |> TagGroup.changeset(attrs)
    |> Repo.insert()
  end

  def update_tags(%{repository_id: repository_id, tags: tags, user_id: user_id}) do
    with {:ok, %TagGroup{} = tag_group} <- Loader.get_tag_group(user_id, repository_id),
         {:ok, %TagGroup{} = updated_tag_group} <- do_update_tags(tag_group, tags) do
      {:ok, updated_tag_group.tags}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_update_tags(tag_group, tags) do
    tag_group
    |> TagGroup.changeset(%{tags: parse_tags(tags)})
    |> Repo.update()
  end

  defp parse_tags(tags) when is_list(tags) do
    tags =
      tags
      |> Enum.map(&parse_tag/1)
      |> MapSet.new()
      |> MapSet.to_list()
  end

  defp parse_tag(tag) when is_binary(tag) do
    tag
    |> String.trim()
    |> String.downcase()
  end
end
