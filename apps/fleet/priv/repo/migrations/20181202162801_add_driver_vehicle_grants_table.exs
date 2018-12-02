defmodule Fleet.Repo.Migrations.AddDriverVehicleGrantsTable do
  use Ecto.Migration

  def change() do
    create(table("driver_vehicle_grants", primary_key: false)) do
      add(:id, :serial, primary_key: true)
      add(:driver_id, references("drivers", type: :integer), null: false)
      add(:vehicle_id, references("vehicles", type: :integer), null: false)
      add(:scope, {:array, :text}, null: false)
      timestamps(type: :utc_datetime, default: fragment("now()"))
    end
  end
end
