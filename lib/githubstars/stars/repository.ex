defmodule Githubstars.Stars.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do
    field :description, :string
    field :github_id, :string
    field :language, :string
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :description, :url, :language, :github_id])
    |> validate_required([:name, :description, :url, :language, :github_id])
  end
end
