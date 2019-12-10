defmodule Twitter.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :feed, :map
    field :followers, {:array, :string}
    field :name, :string
    field :subscribers, {:array, :string}
    field :tweets, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :followers, :subscribers, :feed, :tweets])
    |> validate_required([:name, :followers, :subscribers, :feed, :tweets])
  end
end
