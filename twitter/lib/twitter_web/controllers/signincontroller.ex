defmodule TwitterWeb.SigninController do
  use TwitterWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "Please sign in")
    |> render("index.html")
  end

  def signin(conn, _params) do
    conn
    |> put_flash(:info, "In Signin!")
    |> render("index.html")
  end
end
