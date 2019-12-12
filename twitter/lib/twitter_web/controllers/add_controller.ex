defmodule TwitterWeb.AddController do
  use TwitterWeb, :controller

  alias Twitter.Adds
  alias Twitter.Adds.Add

  def index(conn, %{"user_name" => user_name} = params) do
    # add = Adds.list_add()

    # sender = Map.get(params, :user_name)
    IO.inspect(user_name, label: "in add index")
    render(conn, "index.html", user_name: user_name)
  end

  def addSub(conn, %{"user_name" => user_name} = params) do
    sender = user_name
    IO.inspect(sender, label: "in add sub")
    subs = get_in(params, ["tofollow"])

    {pass_users, tot_users, _, _} = :sys.get_state(:"#{Engine}_cssa")
    tot_users = tot_users -- [sender]

    IO.inspect(tot_users, label: "People you can subscribe")

    # Check if subs exist in system

    conn =
      if subs in tot_users do
        pid_sender = :"#{sender}"
        GenServer.call(pid_sender, {:subscribe, subs})

        conn
        |> put_flash(:info, "Sucess! Now subscribed to #{subs}")
        |> redirect(to: Routes.user_path(conn, :index, user_name: user_name))
      else
        conn
        |> put_flash(:info, "Person you are trying to subscribe does not exist")
        |> redirect(to: Routes.add_path(conn, :index, user_name: user_name))
      end

    add = Adds.list_add()
    conn
  end

  def new(conn, _params) do
    changeset = Adds.change_add(%Add{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"add" => add_params}) do
    case Adds.create_add(add_params) do
      {:ok, add} ->
        conn
        |> put_flash(:info, "Add created successfully.")
        |> redirect(to: Routes.add_path(conn, :show, add))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    add = Adds.get_add!(id)
    render(conn, "show.html", add: add)
  end

  def edit(conn, %{"id" => id}) do
    add = Adds.get_add!(id)
    changeset = Adds.change_add(add)
    render(conn, "edit.html", add: add, changeset: changeset)
  end

  def update(conn, %{"id" => id, "add" => add_params}) do
    add = Adds.get_add!(id)

    case Adds.update_add(add, add_params) do
      {:ok, add} ->
        conn
        |> put_flash(:info, "Add updated successfully.")
        |> redirect(to: Routes.add_path(conn, :show, add))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", add: add, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    add = Adds.get_add!(id)
    {:ok, _add} = Adds.delete_add(add)

    conn
    |> put_flash(:info, "Add deleted successfully.")
    |> redirect(to: Routes.add_path(conn, :index))
  end
end
