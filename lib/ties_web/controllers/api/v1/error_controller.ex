defmodule TiesWeb.Api.V1.ErrorController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "Not Found")
  end

  def call(conn, {:error, :server_error}) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(500, "Internal Server Error")
  end
end