defmodule Githubstars.Users.Loader do
  @moduledoc """
  Load data from the database.
  """
  alias Githubstars.Repo
  alias Githubstars.Users.{User, Queries}

  def one_by_id(id) do
    id
    |> Queries.one_by_id()
    |> Repo.one()
    |> handle_one()
  end

  def one_by_name(username) do
    username
    |> Queries.one_by_name()
    |> Repo.one()
    |> handle_one()
  end

  def handle_one(nil), do: {:error, :user_not_found}
  def handle_one(%User{} = user), do: {:ok, user}
end
