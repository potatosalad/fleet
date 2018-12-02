# Since configuration is shared in umbrella projects, this file
# should only configure the :fleet_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :fleet_web,
  ecto_repos: [Fleet.Repo],
  generators: [context_app: :fleet]

# Configures the endpoint
config :fleet_web, FleetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DOWeGEOH0r8+H4t2JkJOO4hNf2ZlRT21U33ZNvVFYCgK3t41IgR8JjoXsDBNOZpR",
  render_errors: [view: FleetWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FleetWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
