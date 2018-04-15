defmodule TiesWeb.Api.V1.TieTagController do
  use TiesWeb, :controller
  alias Ties.TieTag
  alias Ties.Repo

  action_fallback TiesWeb.Api.V1.ErrorController

  def index(conn, %{"tie_id" => tie_id}) do
    json conn, Repo.all(from t in TieTag, where: t.tie_id == ^tie_id)
  end

  def create(conn, params) do
    changeset = TieTag.changeset(%TieTag{}, params)
    with {:ok, tietag} <- Repo.insert(changeset) do
      json conn |> put_status(:created), tietag
    end
  end

  def delete(conn, %{"tie_id" => tie_id, "name" => name}) do
    json conn, Repo.delete(Repo.get_by(TieTag, tie_id: tie_id, name: name))
  end
end
