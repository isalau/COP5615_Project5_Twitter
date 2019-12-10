defmodule Twitter.Repo.Migrations.CreateSetting do
  use Ecto.Migration

  def change do
    create table(:setting) do
      add :name, :string
      add :password, :string

      timestamps()
    end

  end
end
