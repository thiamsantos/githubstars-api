defmodule Githubstars.Users.Create.Params do
  @moduledoc """
  Schema of a request for a client creation.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :name
  ]

  embedded_schema do
    field :name, :string
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
