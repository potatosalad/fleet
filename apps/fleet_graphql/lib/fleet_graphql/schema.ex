defmodule FleetGraphql.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types(Absinthe.Type.Custom)
  import_types(FleetGraphql.Schema.Driver)
  import_types(FleetGraphql.Schema.DriverVehicleGrant)
  import_types(FleetGraphql.Schema.Node)
  import_types(FleetGraphql.Schema.Vehicle)

  query do
    import_fields(:driver_queries)
    import_fields(:driver_vehicle_grant_queries)
    import_fields(:node_queries)
    import_fields(:vehicle_queries)
  end

  mutation do
    import_fields(:driver_mutations)
    import_fields(:driver_vehicle_grant_mutations)
    import_fields(:vehicle_mutations)
  end
end
