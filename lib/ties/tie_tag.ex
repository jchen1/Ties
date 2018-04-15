defmodule Ties.TieTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @derive {Poison.Encoder, only: [:tie_id, :name, :id]}
  schema "tie_tags" do
    field :name, :string, primary_key: true
    belongs_to :tie, Ties.Tie, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(tie_tag, attrs) do
    tie_tag
    |> cast(attrs, [:tie_id, :name])
    |> foreign_key_constraint(:tie_id)
    |> unique_constraint(:unique_tietag, name: :tietag_index)
    |> validate_required([:tie_id, :name])
  end
end
