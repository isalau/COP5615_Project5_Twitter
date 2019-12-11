defmodule TwitterWeb.RegisterController do
  use TwitterWeb, :controller

  def index(conn, params) do
    # IO.puts(params)

    conn
    |> put_flash(:info, "Please fill out form to register!")
    |> render("index.html")
  end

  def register(conn, params) do
    user_name = get_in(params, ["username"])
    password = get_in(params, ["password1"])
    # IO.inspect(user_name, label: "USERNAME")
    {_, all_users, _, _} = :sys.get_state(:"#{Engine}_cssa")

    if user_name in all_users do
      IO.puts("username already exists")

      conn
      |> put_flash(:info, "Already registered please sign in instead!")
      |> render("index.html")
    else
      Register.reg(user_name, password)
    end

    conn
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
