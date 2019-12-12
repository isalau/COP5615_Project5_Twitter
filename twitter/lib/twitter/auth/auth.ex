defmodule TwitterWeb.Auth do
  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
  end

  def signed_in?(conn) do
    !!current_user(conn)
  end
end
