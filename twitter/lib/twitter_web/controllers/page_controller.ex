defmodule TwitterWeb.PageController do
  use TwitterWeb, :controller

  def register(conn, _params) do
    conn
    |> put_flash(:info, "In register!")
    |> render("index.html")
  end

  def signIn(conn, _params) do
    conn
    |> put_flash(:info, "In signIn!")
    |> render("index.html")
  end

  def wildcard(conn, _params) do
    conn
    |> put_flash(:info, "In wildcard!")
    |> render("index.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
