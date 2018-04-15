defmodule Ties.Repo.Migrations.CreateTieTags do
  use Ecto.Migration

  def change do
    create table(:tie_tags) do
      add :tie_id, references(:ties, on_delete: :nothing)
      add :name, :string

      timestamps()
    end

    create index(:tie_tags, [:tie_id])
    create index(:tie_tags, [:name])
    create unique_index(:tie_tags, [:tie_id, :name], name: :tietag_index)
  end
end
