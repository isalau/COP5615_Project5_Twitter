defmodule Twitter.Repo.Migrations.CreateAdd do
  use Ecto.Migration

  def change do
    create table(:add) do
      add :name, :string
      add :tofollow, :string

      timestamps()
    end

  end
end
