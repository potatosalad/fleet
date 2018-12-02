defmodule FleetGraphql.Schema.DriverVehicleGrant do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object(:driver_vehicle_grant_queries) do
    field(:check_driver_vehicle_access, non_null(:boolean)) do
      arg(:driver_id, non_null(:id))
      arg(:vehicle_id, non_null(:id))
      resolve(&FleetGraphql.Schema.DriverVehicleGrant.check_driver_vehicle_access/3)
    end
  end

  object(:driver_vehicle_grant_mutations) do
    # TODO: uncomment this and write the resolver to grant driver vehicle access
    # payload(field(:grant_driver_vehicle_access)) do
    #   input do
    #     field(:name)
    #   end
    # 
    #   output do
    #     field(:driver, :driver)
    #   end
    # 
    #   resolve(&FleetGraphql.Schema.Driver.create_driver/2)
    # end

    payload(field(:revoke_driver_vehicle_access)) do
      input do
        field(:driver_id, non_null(:id))
        field(:vehicle_id, non_null(:id))
      end

      output do
        field(:result, :boolean)
      end

      resolve(&FleetGraphql.Schema.DriverVehicleGrant.revoke_driver_vehicle_access/2)
    end
  end

  ## Resolvers

  def check_driver_vehicle_access(parent, %{driver_id: driver_id, vehicle_id: vehicle_id}, _info) when map_size(parent) === 0 do
    case decode_driver_and_vehicle_ids(driver_id, vehicle_id) do
      {:ok, driver_id, vehicle_id} ->
        require Ecto.Query

        query =
          Ecto.Query.from(dvg in Fleet.Data.DriverVehicleGrant,
            where: dvg.driver_id == ^driver_id and dvg.vehicle_id == ^vehicle_id and dvg.scope == ^[:access],
            select: dvg,
            limit: 1
          )

        case Fleet.Repo.all(query) do
          [_] ->
            {:ok, true}

          [] ->
            {:ok, false}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  def revoke_driver_vehicle_access(%{driver_id: driver_id, vehicle_id: vehicle_id}, _info) do
    case decode_driver_and_vehicle_ids(driver_id, vehicle_id) do
      {:ok, driver_id, vehicle_id} ->
        require Ecto.Query

        query =
          Ecto.Query.from(dvg in Fleet.Data.DriverVehicleGrant,
            where: dvg.driver_id == ^driver_id and dvg.vehicle_id == ^vehicle_id and dvg.scope == ^[:access]
          )

        _ = Fleet.Repo.delete_all(query)
        output = %{result: true}
        {:ok, output}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc false
  defp decode_driver_and_vehicle_ids(driver_id, vehicle_id) do
    case FleetGraphql.from_global_id(driver_id) do
      {:ok, %{type: :driver, id: driver_id}} ->
        case FleetGraphql.from_global_id(vehicle_id) do
          {:ok, %{type: :vehicle, id: vehicle_id}} ->
            {:ok, driver_id, vehicle_id}

          {:error, reason} ->
            {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end
end
