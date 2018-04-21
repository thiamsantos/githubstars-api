defmodule Githubstars.Repos.Queries do
  @moduledoc """
  Database queries.
  """
  import Ecto.Query, warn: false

  alias Githubstars.Repos.Repository
  alias Githubstars.Tags.TagGroup

  def one_by_github_id(github_id) do
    from r in Repository,
      where: r.github_id == ^github_id,
      select: [:id]
  end

  def all_by_user_id(user_id) do
    from t in TagGroup,
      join: r in Repository,
      on: r.id == t.repository_id,
      where: t.user_id == ^user_id,
      select: r
  end

  def all_by_user_id_and_tag(user_id, tag) do
    from t in TagGroup,
      join: r in Repository,
      on: r.id == t.repository_id,
      where: t.user_id == ^user_id and ^tag in t.tags,
      select: r
  end
end
