defmodule Githubstars.Repos.Mutator do
  @moduledoc """
  Database mutations involving the repositories table.
  """
  alias Githubstars.Repo
  alias Githubstars.Repos.Repository

  def create(attrs) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end
end
