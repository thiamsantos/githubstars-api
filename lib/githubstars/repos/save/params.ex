defmodule Githubstars.Repos.Save.Params do
  @moduledoc """
  Params for get all repos associated with an user.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :user_id,
    :repositories
  ]

  embedded_schema do
    field :user_id, :integer
    field :repositories, {:array, :map}
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
