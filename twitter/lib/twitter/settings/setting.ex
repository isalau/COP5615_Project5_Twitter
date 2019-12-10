defmodule Twitter.Settings.Setting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "setting" do
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
  end
end
