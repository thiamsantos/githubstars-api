defmodule Githubstars.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add(:name, :string)
      add(:description, :string)
      add(:url, :string)
      add(:language, :string)
      add(:github_id, :string)

      timestamps()
    end
  end
end
