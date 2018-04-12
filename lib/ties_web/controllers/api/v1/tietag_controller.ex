defmodule TiesWeb.Api.V1.TieTagController do
  use TiesWeb, :controller
  alias Ties.TieTag
  alias Ties.Tag
  alias Ties.Repo

  action_fallback TiesWeb.Api.V1.ErrorController

  def index(conn, %{"tie_id" => tie_id}) do
    json conn, Repo.all(from tt in TieTag, where: tt.tie_id == ^tie_id, join: t in Tag, on: tt.tag_id == t.id, select: %{"name": t.name, "id": t.id})
  end

  def show(conn, %{"tie_id" => tie_id, "id" => id}) do
    case Repo.one(from tt in TieTag, join: t in Tag, where: tt.tag_id == t.id, where: tt.tie_id == ^tie_id, where: tt.tag_id == ^id) do
      nil -> {:error, :not_found}
      tag -> json conn, tag
    end
  end

  def create(conn, params) do
    changeset = TieTag.changeset(%TieTag{}, params)
    with {:ok, tietag} <- Repo.insert(changeset) do
      json conn |> put_status(:created), tietag
    end
  end

  def delete(conn, %{"tie_id" => tie_id, "id" => id}) do
    json conn, Repo.delete(Repo.get_by(TieTag, tie_id: tie_id, tag_id: id))
  end
end
