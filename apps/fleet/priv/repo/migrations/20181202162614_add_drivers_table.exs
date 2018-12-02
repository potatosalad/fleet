defmodule Fleet.Repo.Migrations.AddDriversTable do
  use Ecto.Migration

  def change() do
    create(table("drivers", primary_key: false)) do
      add(:id, :serial, primary_key: true)
      add(:name, :text, null: false)
      timestamps(type: :utc_datetime, default: fragment("now()"))
    end
  end
end
