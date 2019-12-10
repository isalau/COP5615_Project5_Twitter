defmodule Twitter.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :followers, {:array, :string}
      add :subscribers, {:array, :string}
      add :feed, :map
      add :tweets, {:array, :string}

      timestamps()
    end

  end
end
