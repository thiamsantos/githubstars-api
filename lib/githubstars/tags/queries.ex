defmodule Githubstars.Tags.Queries do
  @moduledoc """
  Ecto queries.
  """
  import Ecto.Query, warn: false

  alias Githubstars.Tags.TagGroup

  def tags_by_user_and_repository(user_id, repository_id) do
    from t in TagGroup,
      where: t.user_id == ^user_id and t.repository_id == ^repository_id,
      select: t.tags
  end

  def one_tag_group(user_id, repository_id) do
    from t in TagGroup,
      where: t.user_id == ^user_id and t.repository_id == ^repository_id,
      select: t
  end
end
