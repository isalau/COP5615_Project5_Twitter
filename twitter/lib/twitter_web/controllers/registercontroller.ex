defmodule TwitterWeb.RegisterController do
  use TwitterWeb, :controller

  def index(conn, params) do
    # IO.puts(params)

    conn
    |> put_flash(:info, "Please fill out form to register!")
    |> render("index.html")
  end

  def register(conn, _params) do
    # Register.reg(:username, :password)

    conn
    |> redirect(to: Routes.user_path(@conn, :index))
  end
end
