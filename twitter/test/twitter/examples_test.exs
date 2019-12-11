defmodule Twitter.ExamplesTest do
  use Twitter.DataCase

  alias Twitter.Examples

  describe "example" do
    alias Twitter.Examples.Example

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def example_fixture(attrs \\ %{}) do
      {:ok, example} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Examples.create_example()

      example
    end

    test "list_example/0 returns all example" do
      example = example_fixture()
      assert Examples.list_example() == [example]
    end

    test "get_example!/1 returns the example with given id" do
      example = example_fixture()
      assert Examples.get_example!(example.id) == example
    end

    test "create_example/1 with valid data creates a example" do
      assert {:ok, %Example{} = example} = Examples.create_example(@valid_attrs)
      assert example.body == "some body"
      assert example.name == "some name"
    end

    test "create_example/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Examples.create_example(@invalid_attrs)
    end

    test "update_example/2 with valid data updates the example" do
      example = example_fixture()
      assert {:ok, %Example{} = example} = Examples.update_example(example, @update_attrs)
      assert example.body == "some updated body"
      assert example.name == "some updated name"
    end

    test "update_example/2 with invalid data returns error changeset" do
      example = example_fixture()
      assert {:error, %Ecto.Changeset{}} = Examples.update_example(example, @invalid_attrs)
      assert example == Examples.get_example!(example.id)
    end

    test "delete_example/1 deletes the example" do
      example = example_fixture()
      assert {:ok, %Example{}} = Examples.delete_example(example)
      assert_raise Ecto.NoResultsError, fn -> Examples.get_example!(example.id) end
    end

    test "change_example/1 returns a example changeset" do
      example = example_fixture()
      assert %Ecto.Changeset{} = Examples.change_example(example)
    end
  end
end
