defmodule FleetGraphql.Schema.Node do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node(interface()) do
    resolve_type(&FleetGraphql.Schema.Node.resolve_type/2)
  end

  object(:node_queries) do
    node(field()) do
      resolve(&FleetGraphql.Schema.Node.resolve_field/3)
    end
  end

  ## Resolvers

  def resolve_field(parent, args, info) when map_size(parent) === 0 do
    case args do
      %{type: :driver, id: _} ->
        FleetGraphql.Schema.Driver.fetch(parent, args, info)

      %{type: :vehicle, id: _} ->
        FleetGraphql.Schema.Vehicle.fetch(parent, args, info)
    end
  end

  def resolve_type(object, _info) do
    case object do
      %Fleet.Data.Driver{} ->
        :driver

      %Fleet.Data.Vehicle{} ->
        :vehicle
    end
  end
end
