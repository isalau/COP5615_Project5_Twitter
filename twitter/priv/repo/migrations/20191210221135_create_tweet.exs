defmodule Twitter.Repo.Migrations.CreateTweet do
  use Ecto.Migration

  def change do
    create table(:tweet) do
      add :body, :text
      add :posted, :naive_datetime
      add :name, :string

      timestamps()
    end

  end
end
