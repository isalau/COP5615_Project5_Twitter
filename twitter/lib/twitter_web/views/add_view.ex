defmodule TwitterWeb.AddView do
  use TwitterWeb, :view

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end
end
