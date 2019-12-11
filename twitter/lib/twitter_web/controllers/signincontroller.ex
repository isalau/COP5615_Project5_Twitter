defmodule TwitterWeb.SigninController do
  use TwitterWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "Please sign in")
    |> render("index.html")
  end

  def signin(conn, params) do
    user_name = get_in(params, ["username"])
    password = get_in(params, ["password1"])

    {pass_users, tot_users, _, _} = :sys.get_state(:"#{Engine}_cssa")
    # IO.inspect(tot_users, label: "Total users list in Login")

    if user_name in tot_users do
      # After checking show
      pid_sender = :"#{user_name}"
      {_, pass2} = List.keyfind(pass_users, pid_sender, 0)

      if pass2 == password do
        IO.puts("Successful sign in")

        conn
        |> redirect(to: Routes.user_path(conn, :index, user_name: user_name))
      else
        IO.puts("Failed sign in")

        conn
        |> put_flash(:info, "Incorrect username or password, plesae try again!")
        |> render("index.html")
      end
    end
  end
end
