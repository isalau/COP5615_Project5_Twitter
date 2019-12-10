defmodule Twitter.Adds do
  @moduledoc """
  The Adds context.
  """

  import Ecto.Query, warn: false
  alias Twitter.Repo

  alias Twitter.Adds.Add

  @doc """
  Returns the list of add.

  ## Examples

      iex> list_add()
      [%Add{}, ...]

  """
  def list_add do
    Repo.all(Add)
  end

  @doc """
  Gets a single add.

  Raises `Ecto.NoResultsError` if the Add does not exist.

  ## Examples

      iex> get_add!(123)
      %Add{}

      iex> get_add!(456)
      ** (Ecto.NoResultsError)

  """
  def get_add!(id), do: Repo.get!(Add, id)

  @doc """
  Creates a add.

  ## Examples

      iex> create_add(%{field: value})
      {:ok, %Add{}}

      iex> create_add(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_add(attrs \\ %{}) do
    %Add{}
    |> Add.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a add.

  ## Examples

      iex> update_add(add, %{field: new_value})
      {:ok, %Add{}}

      iex> update_add(add, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_add(%Add{} = add, attrs) do
    add
    |> Add.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Add.

  ## Examples

      iex> delete_add(add)
      {:ok, %Add{}}

      iex> delete_add(add)
      {:error, %Ecto.Changeset{}}

  """
  def delete_add(%Add{} = add) do
    Repo.delete(add)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking add changes.

  ## Examples

      iex> change_add(add)
      %Ecto.Changeset{source: %Add{}}

  """
  def change_add(%Add{} = add) do
    Add.changeset(add, %{})
  end
end
