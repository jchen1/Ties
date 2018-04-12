defmodule Ties.Repo.Migrations.CreateTieTags do
  use Ecto.Migration

  def change do
    create table(:tie_tags) do
      add :tie_id, references(:ties, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)

      timestamps()
    end

    create index(:tie_tags, [:tie_id])
    create index(:tie_tags, [:tag_id])
    create unique_index(:tie_tags, [:tie_id, :tag_id], name: :tietag_index)
  end
end
