defmodule Githubstars.Users.Mutator do
  @moduledoc """
  Database mutations involving the users table.
  """
  alias Githubstars.Repo
  alias Githubstars.Users.User

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
