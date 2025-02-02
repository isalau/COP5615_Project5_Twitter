defmodule TwitterWeb.ExampleController do
  use TwitterWeb, :controller

  alias Twitter.Examples
  alias Twitter.Examples.Example

  def index(conn, _params) do
    example = Examples.list_example()
    render(conn, "index.html", example: example)
  end

  def new(conn, _params) do
    changeset = Examples.change_example(%Example{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"example" => example_params}) do
    case Examples.create_example(example_params) do
      {:ok, example} ->
        conn
        |> put_flash(:info, "Example created successfully.")
        |> redirect(to: Routes.example_path(conn, :show, example))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    example = Examples.get_example!(id)
    render(conn, "show.html", example: example)
  end

  def edit(conn, %{"id" => id}) do
    example = Examples.get_example!(id)
    changeset = Examples.change_example(example)
    render(conn, "edit.html", example: example, changeset: changeset)
  end

  def update(conn, %{"id" => id, "example" => example_params}) do
    example = Examples.get_example!(id)

    case Examples.update_example(example, example_params) do
      {:ok, example} ->
        conn
        |> put_flash(:info, "Example updated successfully.")
        |> redirect(to: Routes.example_path(conn, :show, example))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", example: example, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    example = Examples.get_example!(id)
    {:ok, _example} = Examples.delete_example(example)

    conn
    |> put_flash(:info, "Example deleted successfully.")
    |> redirect(to: Routes.example_path(conn, :index))
  end
end
