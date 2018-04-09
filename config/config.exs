# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ties,
  ecto_repos: [Ties.Repo]

# Configures the endpoint
config :ties, TiesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IImcunDte3Nbnzw0cR/kF035oXr4UtYcUNq4trH5PpxuJuouGIqa6P0xRuLWCkgi",
  render_errors: [view: TiesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ties.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
