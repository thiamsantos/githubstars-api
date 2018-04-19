defmodule Githubstars.Repos.Queries do
  @moduledoc """
  Database queries.
  """
  import Ecto.Query, warn: false
  alias Githubstars.Repos.Repository

  def one_by_github_id(github_id) do
    from r in Repository,
      where: r.github_id == ^github_id,
      select: [:id]
  end
end
