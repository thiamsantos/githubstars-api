defmodule Githubstars.Tags.Update.Params do
  @moduledoc """
  Params for update the tags associated with an starred repository.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :repository_id,
    :user_id,
    :tags
  ]

  embedded_schema do
    field :repository_id, :string
    field :user_id, :string
    field :tags, {:array, :string}
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
