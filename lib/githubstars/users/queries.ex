defmodule Githubstars.Users.Queries do
  @moduledoc """
  Database queries.
  """
  import Ecto.Query, warn: false

  alias Githubstars.Users.User

  def one_by_name(name) do
    from u in User, where: u.name == ^name
  end

  def one_by_id(id) do
    from u in User, where: u.id == ^id
  end
end
