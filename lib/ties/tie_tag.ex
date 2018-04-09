defmodule Ties.TieTag do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "tie_tags" do
    field :tie_id, :id, primary_key: true
    field :tag_id, :id, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(tie_tag, attrs) do
    tie_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
