defmodule Githubstars.Tags.Mutator do
  @moduledoc """
  Database mutations involving the tags_groups table.
  """
  alias Githubstars.Repo
  alias Githubstars.Tags.TagGroup

  def initiate_tag_groups(repository_id, user_id) do
    attrs = %{repository_id: repository_id, user_id: user_id, tags: []}

    %TagGroup{}
    |> TagGroup.changeset(attrs)
    |> Repo.insert()
  end
end
