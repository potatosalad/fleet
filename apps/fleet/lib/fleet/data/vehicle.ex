defmodule Fleet.Data.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  schema("vehicles") do
    field(:vin, :string)
    timestamps(type: :utc_datetime)
  end

  def changeset(struct = %__MODULE__{}, params) do
    struct
    |> cast(params, [
      :vin
    ])
    |> validate_required([
      :vin
    ])
    |> unique_constraint(:vin)
  end
end
