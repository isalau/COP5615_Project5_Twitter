defmodule TwitterWeb.AddControllerTest do
  use TwitterWeb.ConnCase

  alias Twitter.Adds

  @create_attrs %{name: "some name", tofollow: "some tofollow"}
  @update_attrs %{name: "some updated name", tofollow: "some updated tofollow"}
  @invalid_attrs %{name: nil, tofollow: nil}

  def fixture(:add) do
    {:ok, add} = Adds.create_add(@create_attrs)
    add
  end

  describe "index" do
    test "lists all add", %{conn: conn} do
      conn = get(conn, Routes.add_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Add"
    end
  end

  describe "new add" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.add_path(conn, :new))
      assert html_response(conn, 200) =~ "New Add"
    end
  end

  describe "create add" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.add_path(conn, :create), add: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.add_path(conn, :show, id)

      conn = get(conn, Routes.add_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Add"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.add_path(conn, :create), add: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Add"
    end
  end

  describe "edit add" do
    setup [:create_add]

    test "renders form for editing chosen add", %{conn: conn, add: add} do
      conn = get(conn, Routes.add_path(conn, :edit, add))
      assert html_response(conn, 200) =~ "Edit Add"
    end
  end

  describe "update add" do
    setup [:create_add]

    test "redirects when data is valid", %{conn: conn, add: add} do
      conn = put(conn, Routes.add_path(conn, :update, add), add: @update_attrs)
      assert redirected_to(conn) == Routes.add_path(conn, :show, add)

      conn = get(conn, Routes.add_path(conn, :show, add))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, add: add} do
      conn = put(conn, Routes.add_path(conn, :update, add), add: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Add"
    end
  end

  describe "delete add" do
    setup [:create_add]

    test "deletes chosen add", %{conn: conn, add: add} do
      conn = delete(conn, Routes.add_path(conn, :delete, add))
      assert redirected_to(conn) == Routes.add_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.add_path(conn, :show, add))
      end
    end
  end

  defp create_add(_) do
    add = fixture(:add)
    {:ok, add: add}
  end
end
