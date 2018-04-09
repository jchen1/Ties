defmodule Ties.Tie do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ties" do
    field :first_name, :string
    field :last_conversation, :utc_datetime
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(tie, attrs) do
    tie
    |> cast(attrs, [:first_name, :last_name, :last_conversation])
    |> validate_required([:first_name, :last_name, :last_conversation])
  end
end
