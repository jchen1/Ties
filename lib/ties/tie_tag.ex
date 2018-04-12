defmodule Ties.TieTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @derive {Poison.Encoder, only: [:tie_id, :tag_id, :id]}
  schema "tie_tags" do
    field :tie_id, :id, primary_key: true
    field :tag_id, :id, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(tie_tag, attrs) do
    tie_tag
    |> cast(attrs, [:tie_id, :tag_id])
    |> foreign_key_constraint(:tie_id)
    |> foreign_key_constraint(:tag_id)
    |> unique_constraint(:unique_tietag, name: :tietag_index)
    |> validate_required([:tie_id, :tag_id])
  end
end
