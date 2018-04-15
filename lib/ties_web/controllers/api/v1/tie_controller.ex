defmodule TiesWeb.Api.V1.TieController do
  use TiesWeb, :controller
  alias Ties.Tie
  alias Ties.TieTag
  alias Ties.Repo
  alias Ecto.Multi

  action_fallback TiesWeb.Api.V1.ErrorController

  def index(conn, _params) do
    json conn, Repo.all(Tie) |> Repo.preload(:tags)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Tie, id) |> Repo.preload(:tags) do
      nil -> {:error, :not_found}
      tag -> json conn, tag
    end
  end

  def create(conn, params) do
    changeset = Tie.changeset(%Tie{}, params)
    with {:ok, tie} <- Repo.insert(changeset) do
      json conn |> put_status(:created), (tie |> Repo.preload(:tags))
    end
  end

  def update(conn, %{"id" => id, "last_conversation" => last_conversation} = params) do
    case Repo.get(Tie, id) |> Repo.preload(:tags) do
      tie ->
        changeset = Tie.changeset(tie, params)
        with {:ok, tie} <- Repo.update(changeset) do
          json conn |> put_status(:ok), tie
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <-
      Multi.new
        |> Multi.delete_all(:tietag, from(t in TieTag, where: t.tie_id == ^id))
        |> Multi.delete(:tie, Repo.get(Tie, id))
        |> Repo.transaction do
      send_resp(conn, 200, "")
    end
  end
end
