defmodule Ties.Tie do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:first_name, :last_conversation, :last_name, :id]}
  schema "ties" do
    field :first_name, :string
    field :last_conversation, :utc_datetime
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(tie, attrs) do
    with attrs <- Map.put(attrs, "last_conversation", DateTime.from_unix!(0)) do
      tie
      |> cast(attrs, [:first_name, :last_name, :last_conversation])
      |> validate_required([:first_name, :last_name, :last_conversation])
    end
  end
end
