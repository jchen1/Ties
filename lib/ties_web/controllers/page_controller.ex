defmodule TiesWeb.PageController do
  use TiesWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
