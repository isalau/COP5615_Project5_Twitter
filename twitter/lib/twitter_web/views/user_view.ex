defmodule TwitterWeb.UserView do
  use TwitterWeb, :view

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end

  def get_keys(username) do
    id = :"#{username}_cssa"
    {_, _, _, tweets} = :sys.get_state(id)
    tweets = tweets
  end
end
