defmodule Twitter.Querys.Query do
  use Ecto.Schema
  import Ecto.Changeset

  schema "querys" do
    field :posted, :naive_datetime
    field :search, :string

    timestamps()
  end

  @doc false
  def changeset(query, attrs) do
    query
    |> cast(attrs, [:search, :posted])
    |> validate_required([:search, :posted])
  end
end
