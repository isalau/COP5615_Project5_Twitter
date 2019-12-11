defmodule Twitter.Repo.Migrations.CreateExample do
  use Ecto.Migration

  def change do
    create table(:example) do
      add :body, :text
      add :name, :string

      timestamps()
    end

  end
end
