# Since configuration is shared in umbrella projects, this file
# should only configure the :fleet application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :fleet, Fleet.Repo,
  username: "postgres",
  password: "postgres",
  database: "fleet_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
