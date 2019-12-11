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
    IO.inspect(user_name, label: "USERNAME")

    # %{
    #   "_csrf_token" => "NAckbA4HK3c9LmEtVScJKyAjH1AjSBUrB2M9jCsNvV6B6ONlpsw6Ne_H",
    #   "_utf8" => "✓",
    #   "body" => "asdas"
    # }

    # Register.reg(:username, :password)

    conn
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
