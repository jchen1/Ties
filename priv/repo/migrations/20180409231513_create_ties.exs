defmodule Ties.Repo.Migrations.CreateTies do
  use Ecto.Migration

  def change do
    create table(:ties) do
      add :first_name, :string
      add :last_name, :string
      add :last_conversation, :utc_datetime

      timestamps()
    end

  end
end
