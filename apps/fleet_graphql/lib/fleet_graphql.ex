defmodule FleetGraphql do
  @schema FleetGraphql.Schema

  def from_global_id(global_id) do
    Absinthe.Relay.Node.from_global_id(global_id, @schema)
  end

  def to_global_id(node_type, source_id) do
    Absinthe.Relay.Node.to_global_id(node_type, source_id, @schema)
  end
end
