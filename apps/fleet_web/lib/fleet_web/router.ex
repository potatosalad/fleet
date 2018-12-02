defmodule FleetWeb.Router do
  use FleetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FleetWeb do
    pipe_through :api
  end
end
