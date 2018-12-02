defmodule FleetGraphql.MixProject do
  use Mix.Project

  def project() do
    [
      app: :fleet_graphql,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:absinthe, "~> 1.5.0-alpha", override: true},
      {:absinthe_plug, github: "absinthe-graphql/absinthe_plug", branch: "master", override: true},
      {:absinthe_phoenix, github: "absinthe-graphql/absinthe_phoenix", branch: "master"},
      {:absinthe_relay, "~> 1.5.0-alpha"},
      {:apollo_tracing, "~> 0.4"},
      {:ecto, "~> 3.0", override: true},
      {:ojson, "~> 1.0"},
      {:phoenix, "~> 1.4.0", override: true},

      # Umbrella
      {:fleet, in_umbrella: true}
    ]
  end
end
