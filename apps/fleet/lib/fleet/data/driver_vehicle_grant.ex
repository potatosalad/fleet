defmodule Fleet.Data.DriverVehicleGrant do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  schema("driver_vehicle_grants") do
    belongs_to(:driver, Fleet.Data.Driver)
    belongs_to(:vehicle, Fleet.Data.Vehicle)
    field(:scope, {:array, Fleet.Ecto.Atom})
    timestamps(type: :utc_datetime)
  end

  def changeset(struct = %__MODULE__{}, params) do
    struct
    |> cast(params, [
      :driver_id,
      :vehicle_id,
      :scope
    ])
    |> validate_required([
      :driver_id,
      :vehicle_id,
      :scope
    ])
  end
end
