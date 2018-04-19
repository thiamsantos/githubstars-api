defmodule Githubstars.Repo.Migrations.CreateTagGroups do
  use Ecto.Migration

  def change do
    create table(:tag_groups) do
      add(:tags, {:array, :string})
      add(:user_id, references(:users, on_delete: :nothing))
      add(:repository_id, references(:repositories, on_delete: :nothing))

      timestamps()
    end

    create(index(:tag_groups, [:user_id]))
    create(index(:tag_groups, [:repository_id]))
    create(unique_index(:tag_groups, [:user_id, :repository_id]))
  end
end
