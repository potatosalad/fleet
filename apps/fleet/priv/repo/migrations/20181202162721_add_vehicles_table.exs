defmodule Fleet.Repo.Migrations.AddVehiclesTable do
  use Ecto.Migration

  def change() do
    create(table("vehicles", primary_key: false)) do
      add(:id, :serial, primary_key: true)
      add(:vin, :text, null: false)
      timestamps(type: :utc_datetime, default: fragment("now()"))
    end

    create(unique_index("vehicles", [:vin]))
  end
end
