defmodule FleetGraphql.Plug do
  @behaviour Plug

  @impl Plug
  def init(opts) do
    opts
  end

  @impl Plug
  def call(conn = %Plug.Conn{}, _opts) do
    context = %{now: DateTime.utc_now()}
    Absinthe.Plug.put_options(conn, context: context)
  end
end
