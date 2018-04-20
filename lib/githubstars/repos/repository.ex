defmodule Githubstars.Repos.Repository do
  @moduledoc """
  Starred repository schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name, :description, :url, :github_id]
  @optional_fields [:language]

  schema "repositories" do
    field :description, :string
    field :github_id, :integer
    field :language, :string
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
