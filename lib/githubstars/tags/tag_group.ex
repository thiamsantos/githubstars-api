defmodule Githubstars.Tags.TagGroup do
  @moduledoc """
  TagGroup schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:tags, :user_id, :repository_id]

  schema "tag_groups" do
    field :tags, {:array, :string}
    field :user_id, :id
    field :repository_id, :id

    timestamps()
  end

  @doc false
  def changeset(tag_group, attrs) do
    tag_group
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:repository_id)
  end
end
