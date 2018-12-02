# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fleet.Repo.insert!(%Fleet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Fleet.Repo.transaction(fn ->
  driver_adams_changeset = Fleet.Data.Driver.changeset(%Fleet.Data.Driver{}, %{name: "Adams"})
  driver_adams = %Fleet.Data.Driver{} = Fleet.Repo.insert!(driver_adams_changeset)

  driver_baker_changeset = Fleet.Data.Driver.changeset(%Fleet.Data.Driver{}, %{name: "Baker"})
  driver_baker = %Fleet.Data.Driver{} = Fleet.Repo.insert!(driver_baker_changeset)

  driver_clark_changeset = Fleet.Data.Driver.changeset(%Fleet.Data.Driver{}, %{name: "Clark"})
  driver_clark = %Fleet.Data.Driver{} = Fleet.Repo.insert!(driver_clark_changeset)

  driver_davis_changeset = Fleet.Data.Driver.changeset(%Fleet.Data.Driver{}, %{name: "Davis"})
  driver_davis = %Fleet.Data.Driver{} = Fleet.Repo.insert!(driver_davis_changeset)

  driver_evans_changeset = Fleet.Data.Driver.changeset(%Fleet.Data.Driver{}, %{name: "Evans"})
  driver_evans = %Fleet.Data.Driver{} = Fleet.Repo.insert!(driver_evans_changeset)

  vehicle_a1_changeset = Fleet.Data.Vehicle.changeset(%Fleet.Data.Vehicle{}, %{vin: "A1"})
  vehicle_a1 = %Fleet.Data.Vehicle{} = Fleet.Repo.insert!(vehicle_a1_changeset)

  vehicle_b2_changeset = Fleet.Data.Vehicle.changeset(%Fleet.Data.Vehicle{}, %{vin: "B2"})
  vehicle_b2 = %Fleet.Data.Vehicle{} = Fleet.Repo.insert!(vehicle_b2_changeset)

  vehicle_c3_changeset = Fleet.Data.Vehicle.changeset(%Fleet.Data.Vehicle{}, %{vin: "C3"})
  vehicle_c3 = %Fleet.Data.Vehicle{} = Fleet.Repo.insert!(vehicle_c3_changeset)

  _ =
    Fleet.Repo.insert!(
      Fleet.Data.DriverVehicleGrant.changeset(%Fleet.Data.DriverVehicleGrant{}, %{
        driver_id: driver_adams.id,
        vehicle_id: vehicle_a1.id,
        scope: [:access]
      })
    )

  _ =
    Fleet.Repo.insert!(
      Fleet.Data.DriverVehicleGrant.changeset(%Fleet.Data.DriverVehicleGrant{}, %{
        driver_id: driver_adams.id,
        vehicle_id: vehicle_b2.id,
        scope: [:access]
      })
    )

  _ =
    Fleet.Repo.insert!(
      Fleet.Data.DriverVehicleGrant.changeset(%Fleet.Data.DriverVehicleGrant{}, %{
        driver_id: driver_adams.id,
        vehicle_id: vehicle_c3.id,
        scope: [:access]
      })
    )

  _ =
    Fleet.Repo.insert!(
      Fleet.Data.DriverVehicleGrant.changeset(%Fleet.Data.DriverVehicleGrant{}, %{
        driver_id: driver_baker.id,
        vehicle_id: vehicle_b2.id,
        scope: [:access]
      })
    )
end)
