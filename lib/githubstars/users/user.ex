defmodule Githubstars.Users.User do
  @moduledoc """
  User schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name]

  schema "users" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
