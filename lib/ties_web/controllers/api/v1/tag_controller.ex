defmodule TiesWeb.Api.V1.TagController do
  use TiesWeb, :controller
  alias Ties.Tag
  alias Ties.Repo

  action_fallback TiesWeb.Api.V1.ErrorController

  def index(conn, _params) do
    json conn, Repo.all(Tag)
  end

  def show(conn, %{"name" => name}) do
    case Repo.one(from t in Tag, where: t.name == ^name) do
      tag -> json conn, tag
      _ -> {:error, :not_found}
    end
  end

  def create(conn, params) do
    changeset = Tag.changeset(%Tag{}, params)
    with {:ok, tag} <- Repo.insert(changeset) do
      json conn |> put_status(:created), tag
    end
  end

  def delete(conn, %{"name" => name}) do
    json conn, Repo.delete(Repo.one(from t in Tag, where: t.name == ^name))
  end
end
