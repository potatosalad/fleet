defmodule FleetWeb.Router do
  use FleetWeb, :router

  scope("/api") do
    forward("/", FleetGraphql.Router)
  end
end
