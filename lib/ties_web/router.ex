defmodule TiesWeb.Router do
  use TiesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TiesWeb.Api do
    pipe_through :api
    scope "/v1", V1, as: :v1 do
      resources "/ties", TieController, except: [:edit, :new] do
        resources "/tags", TieTagController, except: [:edit, :new, :update]
      end
      resources "/tags", TagController, except: [:edit, :new], param: "name"
      get "/healthcheck", ApiController, :healthcheck
      get "/version", ApiController, :version
      get "/", ApiController, :index
    end
  end

  scope "/", TiesWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
