defmodule Twitter.Repo.Migrations.CreateQuerys do
  use Ecto.Migration

  def change do
    create table(:querys) do
      add :search, :text
      add :posted, :naive_datetime

      timestamps()
    end

  end
end
