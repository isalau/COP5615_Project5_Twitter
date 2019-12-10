defmodule TwitterWeb.RegisterController do
  use TwitterWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "In register!")
    |> render("index.html")
  end
end
