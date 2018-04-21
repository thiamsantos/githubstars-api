defmodule Githubstars.Tags.All.Params do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :repository_id,
    :user_id
  ]

  embedded_schema do
    field :repository_id, :string
    field :user_id, :string
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
