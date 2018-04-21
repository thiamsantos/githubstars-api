defmodule Githubstars.Repos.All.Params do
  @moduledoc """
  Params for get all repos associated with an user.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :user_id
  ]

  @optional_fields [
    :tag
  ]

  embedded_schema do
    field :tag, :string
    field :user_id, :string
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
