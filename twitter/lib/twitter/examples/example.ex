defmodule Twitter.Examples.Example do
  use Ecto.Schema
  import Ecto.Changeset

  schema "example" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(example, attrs) do
    example
    |> cast(attrs, [:body, :name])
    |> validate_required([:body, :name])
  end
end
