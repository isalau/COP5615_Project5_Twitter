defmodule Twitter.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweet" do
    field :body, :string
    field :name, :string
    field :posted, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:body, :posted, :name])
    |> validate_required([:body, :posted, :name])
  end
end
