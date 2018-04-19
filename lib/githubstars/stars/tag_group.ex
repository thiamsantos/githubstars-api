defmodule Githubstars.Stars.TagGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag_groups" do
    field :tags, {:array, :string}
    field :user_id, :id
    field :repository_id, :id

    timestamps()
  end

  @doc false
  def changeset(tag_group, attrs) do
    tag_group
    |> cast(attrs, [:tags])
    |> validate_required([:tags])
  end
end
