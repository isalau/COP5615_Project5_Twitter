defmodule TwitterWeb.UName do
  import Plug.Conn

  def uname(conn, params) do
    IO.inspect(params, label: "in uname")
    assign(conn, :uname, params)
  end
end
