defmodule Twitter.QuerysTest do
  use Twitter.DataCase

  alias Twitter.Querys

  describe "querys" do
    alias Twitter.Querys.Query

    @valid_attrs %{posted: ~N[2010-04-17 14:00:00], search: "some search"}
    @update_attrs %{posted: ~N[2011-05-18 15:01:01], search: "some updated search"}
    @invalid_attrs %{posted: nil, search: nil}

    def query_fixture(attrs \\ %{}) do
      {:ok, query} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Querys.create_query()

      query
    end

    test "list_querys/0 returns all querys" do
      query = query_fixture()
      assert Querys.list_querys() == [query]
    end

    test "get_query!/1 returns the query with given id" do
      query = query_fixture()
      assert Querys.get_query!(query.id) == query
    end

    test "create_query/1 with valid data creates a query" do
      assert {:ok, %Query{} = query} = Querys.create_query(@valid_attrs)
      assert query.posted == ~N[2010-04-17 14:00:00]
      assert query.search == "some search"
    end

    test "create_query/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Querys.create_query(@invalid_attrs)
    end

    test "update_query/2 with valid data updates the query" do
      query = query_fixture()
      assert {:ok, %Query{} = query} = Querys.update_query(query, @update_attrs)
      assert query.posted == ~N[2011-05-18 15:01:01]
      assert query.search == "some updated search"
    end

    test "update_query/2 with invalid data returns error changeset" do
      query = query_fixture()
      assert {:error, %Ecto.Changeset{}} = Querys.update_query(query, @invalid_attrs)
      assert query == Querys.get_query!(query.id)
    end

    test "delete_query/1 deletes the query" do
      query = query_fixture()
      assert {:ok, %Query{}} = Querys.delete_query(query)
      assert_raise Ecto.NoResultsError, fn -> Querys.get_query!(query.id) end
    end

    test "change_query/1 returns a query changeset" do
      query = query_fixture()
      assert %Ecto.Changeset{} = Querys.change_query(query)
    end
  end
end
