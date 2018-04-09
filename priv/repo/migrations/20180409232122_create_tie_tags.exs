defmodule Ties.Repo.Migrations.CreateTieTags do
  use Ecto.Migration

  def change do
    create table(:tie_tags) do
      add :tie_id, references(:ties, on_delete: :nothing), primary_key: true
      add :tag_id, references(:tags, on_delete: :nothing), primary_key: true

      timestamps()
    end

    create index(:tie_tags, [:tie_id])
    create index(:tie_tags, [:tag_id])
  end
end
