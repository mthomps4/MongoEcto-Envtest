# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :envtest,
  ecto_repos: [Envtest.Repo]

# Configures the endpoint
config :envtest, Envtest.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XtTOa0//EwsQusYqHYwtfxhA/0uKs9eY6XGPtqLI20JYIWxBwZ4Mzj9OcRUWba/e",
  render_errors: [view: Envtest.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Envtest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
