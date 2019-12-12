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
    password1 = get_in(params, ["password1"])
    password2 = get_in(params, ["password2"])
    {_, all_users, _, _} = :sys.get_state(:"#{Engine}_cssa")

    if password1 == "" do
      conn
      |> put_flash(:info, "Passwords cannot be nil")
      |> render("index.html")
    else
      conn =
        if user_name in all_users do
          IO.puts("username already exists")

          conn
          |> put_flash(:info, "Already registered please sign in instead!")
          |> redirect(to: Routes.page_path(conn, :index, user_name: user_name))
        else
          if password1 == password2 do
            Register.reg(user_name, password1)

            conn
            |> put_session(:current_user_id, user_name)
            |> redirect(to: Routes.user_path(conn, :index, user_name: user_name))
          else
            conn
            |> put_flash(:info, "Passwords do not match. Please try again")
            |> render("index.html")
          end
        end
    end
  end
end
