defmodule FleetGraphql.Router do
  use Phoenix.Router

  pipeline(:context) do
    plug(FleetGraphql.Plug)
  end

  scope("/") do
    pipe_through([:context])

    forward(
      "/graphql",
      Absinthe.Plug,
      schema: FleetGraphql.Schema,
      json_codec: OJSON,
      pipeline: {ApolloTracing.Pipeline, :plug}
    )

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: FleetGraphql.Schema,
      json_codec: OJSON,
      interface: :playground,
      pipeline: {ApolloTracing.Pipeline, :plug}
    )
  end
end
