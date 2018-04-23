defmodule Githubstars.Repos.Show.Params do
  @moduledoc """
  Params to show one repo associated with an user.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :user_id,
    :id
  ]

  embedded_schema do
    field :user_id, :string
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
