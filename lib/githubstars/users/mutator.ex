defmodule Githubstars.Users.Mutator do
  @moduledoc """
  Database mutations involving the users table.
  """
  alias Githubstars.Repo
  alias Githubstars.Users.User

  def create(username) do
    %User{}
    |> User.changeset(%{name: username})
    |> Repo.insert()
  end
end
