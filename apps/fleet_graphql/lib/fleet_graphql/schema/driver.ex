defmodule FleetGraphql.Schema.Driver do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node(object(:driver)) do
    field(:name, non_null(:string))

    field(:accessible_vehicles, list_of(non_null(:vehicle))) do
      resolve(&FleetGraphql.Schema.Vehicle.list_accessible_for_driver/3)
    end

    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))
  end

  object(:driver_queries) do
    field(:drivers, list_of(non_null(:driver))) do
      resolve(&FleetGraphql.Schema.Driver.list/3)
    end
  end

  object(:driver_mutations) do
    # TODO: uncomment this and write the resolver to create drivers (see vehicles for example)
    # payload(field(:create_driver)) do
    #   input do
    #     field(:name, non_null(:string))
    #   end
    # 
    #   output do
    #     field(:driver, :driver)
    #   end
    # 
    #   resolve(&FleetGraphql.Schema.Driver.create_driver/2)
    # end

    # TODO: uncomment this and write the resolver to update drivers
    # payload(field(:update_driver)) do
    #   input do
    #     field(:id, non_null(:id))
    #     field(:name, :string)
    #   end
    # 
    #   output do
    #     field(:driver, :driver)
    #   end
    # 
    #   resolve(&FleetGraphql.Schema.Driver.update_driver/2)
    # end
  end

  ## Resolvers

  def fetch(parent, %{type: :driver, id: driver_id}, _info) when map_size(parent) === 0 do
    require Ecto.Query
    query = Ecto.Query.from(d in Fleet.Data.Driver, where: d.id == ^driver_id)

    case Fleet.Repo.one(query) do
      driver = %Fleet.Data.Driver{} ->
        {:ok, driver}

      nil ->
        {:ok, nil}
    end
  end

  def list(parent, _args, _info) when map_size(parent) === 0 do
    require Ecto.Query
    query = Ecto.Query.from(d in Fleet.Data.Driver, order_by: [asc: d.id])
    drivers = Fleet.Repo.all(query)
    {:ok, drivers}
  end
end
