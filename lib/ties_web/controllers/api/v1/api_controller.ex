defmodule TiesWeb.Api.V1.ApiController do
  use TiesWeb, :controller

  def healthcheck(conn, _params) do
    json conn, %{healthy: true}
  end

  def version(conn, _params) do
    {:ok, vsn} = :application.get_key(:ties, :vsn)
    json conn, %{version: List.to_string(vsn)}
  end

  def index(conn, _params) do
    conn
    |> send_resp(200, "")
  end
end
