defmodule Twitter.AddsTest do
  use Twitter.DataCase

  alias Twitter.Adds

  describe "add" do
    alias Twitter.Adds.Add

    @valid_attrs %{name: "some name", tofollow: "some tofollow"}
    @update_attrs %{name: "some updated name", tofollow: "some updated tofollow"}
    @invalid_attrs %{name: nil, tofollow: nil}

    def add_fixture(attrs \\ %{}) do
      {:ok, add} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Adds.create_add()

      add
    end

    test "list_add/0 returns all add" do
      add = add_fixture()
      assert Adds.list_add() == [add]
    end

    test "get_add!/1 returns the add with given id" do
      add = add_fixture()
      assert Adds.get_add!(add.id) == add
    end

    test "create_add/1 with valid data creates a add" do
      assert {:ok, %Add{} = add} = Adds.create_add(@valid_attrs)
      assert add.name == "some name"
      assert add.tofollow == "some tofollow"
    end

    test "create_add/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Adds.create_add(@invalid_attrs)
    end

    test "update_add/2 with valid data updates the add" do
      add = add_fixture()
      assert {:ok, %Add{} = add} = Adds.update_add(add, @update_attrs)
      assert add.name == "some updated name"
      assert add.tofollow == "some updated tofollow"
    end

    test "update_add/2 with invalid data returns error changeset" do
      add = add_fixture()
      assert {:error, %Ecto.Changeset{}} = Adds.update_add(add, @invalid_attrs)
      assert add == Adds.get_add!(add.id)
    end

    test "delete_add/1 deletes the add" do
      add = add_fixture()
      assert {:ok, %Add{}} = Adds.delete_add(add)
      assert_raise Ecto.NoResultsError, fn -> Adds.get_add!(add.id) end
    end

    test "change_add/1 returns a add changeset" do
      add = add_fixture()
      assert %Ecto.Changeset{} = Adds.change_add(add)
    end
  end
end
