defmodule Fleet.Data.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  schema("drivers") do
    field(:name, :string)
    timestamps(type: :utc_datetime)
  end

  def changeset(struct = %__MODULE__{}, params) do
    struct
    |> cast(params, [
      :name
    ])
    |> validate_required([
      :name
    ])
  end
end
