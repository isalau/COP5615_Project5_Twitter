defmodule Twitter.Adds.Add do
  use Ecto.Schema
  import Ecto.Changeset

  schema "add" do
    field :name, :string
    field :tofollow, :string

    timestamps()
  end

  @doc false
  def changeset(add, attrs) do
    add
    |> cast(attrs, [:name, :tofollow])
    |> validate_required([:name, :tofollow])
  end
end
