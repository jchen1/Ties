defmodule TiesWeb.Api.V1.TieController do
  use TiesWeb, :controller
  alias Ties.Tie
  alias Ties.Repo

  action_fallback TiesWeb.Api.V1.ErrorController

  def index(conn, _params) do
    json conn, Repo.all(Tie)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Tie, id) do
      nil -> {:error, :not_found}
      tag -> json conn, tag
    end
  end

  def create(conn, params) do
    changeset = Tie.changeset(%Tie{}, params)
    with {:ok, tie} <- Repo.insert(changeset) do
      json conn |> put_status(:created), tie
    end
  end

  def update(conn, %{"id" => id, "last_conversation" => last_conversation} = params) do
    IO.puts last_conversation
    case Repo.get(Tie, id) do
      tie ->
        changeset = Tie.changeset(tie, params)
        with {:ok, tie} <- Repo.update(changeset) do
          json conn |> put_status(:ok), tie
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    json conn, Repo.delete(Repo.get(Tie, id))
  end
end
