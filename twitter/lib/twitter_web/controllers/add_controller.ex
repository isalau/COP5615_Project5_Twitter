defmodule TwitterWeb.AddController do
  use TwitterWeb, :controller

  alias Twitter.Adds
  alias Twitter.Adds.Add

  def index(conn, _params) do
    add = Adds.list_add()
    render(conn, "index.html", add: add)
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
