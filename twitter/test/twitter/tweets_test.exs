defmodule Twitter.TweetsTest do
  use Twitter.DataCase

  alias Twitter.Tweets

  describe "tweet" do
    alias Twitter.Tweets.Tweet

    @valid_attrs %{body: "some body", name: "some name", posted: ~N[2010-04-17 14:00:00]}
    @update_attrs %{body: "some updated body", name: "some updated name", posted: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{body: nil, name: nil, posted: nil}

    def tweet_fixture(attrs \\ %{}) do
      {:ok, tweet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tweets.create_tweet()

      tweet
    end

    test "list_tweet/0 returns all tweet" do
      tweet = tweet_fixture()
      assert Tweets.list_tweet() == [tweet]
    end

    test "get_tweet!/1 returns the tweet with given id" do
      tweet = tweet_fixture()
      assert Tweets.get_tweet!(tweet.id) == tweet
    end

    test "create_tweet/1 with valid data creates a tweet" do
      assert {:ok, %Tweet{} = tweet} = Tweets.create_tweet(@valid_attrs)
      assert tweet.body == "some body"
      assert tweet.name == "some name"
      assert tweet.posted == ~N[2010-04-17 14:00:00]
    end

    test "create_tweet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tweets.create_tweet(@invalid_attrs)
    end

    test "update_tweet/2 with valid data updates the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{} = tweet} = Tweets.update_tweet(tweet, @update_attrs)
      assert tweet.body == "some updated body"
      assert tweet.name == "some updated name"
      assert tweet.posted == ~N[2011-05-18 15:01:01]
    end

    test "update_tweet/2 with invalid data returns error changeset" do
      tweet = tweet_fixture()
      assert {:error, %Ecto.Changeset{}} = Tweets.update_tweet(tweet, @invalid_attrs)
      assert tweet == Tweets.get_tweet!(tweet.id)
    end

    test "delete_tweet/1 deletes the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{}} = Tweets.delete_tweet(tweet)
      assert_raise Ecto.NoResultsError, fn -> Tweets.get_tweet!(tweet.id) end
    end

    test "change_tweet/1 returns a tweet changeset" do
      tweet = tweet_fixture()
      assert %Ecto.Changeset{} = Tweets.change_tweet(tweet)
    end
  end
end
