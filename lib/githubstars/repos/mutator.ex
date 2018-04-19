defmodule Githubstars.Repos.Mutator do
  alias Githubstars.Repo
  alias Githubstars.Repos.Repository
  alias Githubstars.Repos.TagGroup

  def create(attrs) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  def initiate_tag_groups(repository_id, user_id) do
    attrs = %{repository_id: repository_id, user_id: user_id, tags: []}

    %TagGroup{}
    |> TagGroup.changeset(attrs)
    |> Repo.insert()
  end
end
