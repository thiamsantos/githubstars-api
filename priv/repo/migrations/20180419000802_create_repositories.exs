defmodule Githubstars.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add(:name, :string)
      add(:description, :text)
      add(:url, :string)
      add(:language, :string)
      add(:github_id, :integer)

      timestamps()
    end

    create(unique_index(:repositories, [:github_id]))
  end
end
