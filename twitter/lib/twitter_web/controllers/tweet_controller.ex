defmodule TwitterWeb.TweetController do
  use TwitterWeb, :controller

  # alias Twitter.Tweets
  # alias Twitter.Tweets.Tweet

  # def index(conn, _params) do
  #   tweet = Tweets.list_tweet()
  #   render(conn, "index.html", tweet: tweet)
  # end

  # def new(conn, _params) do
  #   changeset = Tweets.change_tweet(%Tweet{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def tweet(conn, params) do
    IO.inspect("IN TWEET CONTROLLER")
    sender = get_in(params, ["user_name"])
    IO.inspect(sender, label: "Im sending the tweet0")
    tweet = get_in(params, ["tweet_text"])
    Tweet.send_tweet(sender, tweet, conn)

    conn
    |> redirect(to: Routes.user_path(conn, :index, user_name: sender))
  end

  def got_mssg(conn, user) do
    # conn
    # |> redirect(to: Routes.user_path(conn, :index2, user_name: user))
  end

  #   def create(conn, %{"tweet" => tweet_params}) do
  #     case Tweets.create_tweet(tweet_params) do
  #       {:ok, tweet} ->
  #         conn
  #         |> put_flash(:info, "Tweet created successfully.")
  #         |> redirect(to: Routes.tweet_path(conn, :show, tweet))

  #       {:error, %Ecto.Changeset{} = changeset} ->
  #         render(conn, "new.html", changeset: changeset)
  #     end
  #   end

  #   def show(conn, %{"id" => id}) do
  #     tweet = Tweets.get_tweet!(id)
  #     render(conn, "show.html", tweet: tweet)
  #   end

  #   def edit(conn, %{"id" => id}) do
  #     tweet = Tweets.get_tweet!(id)
  #     changeset = Tweets.change_tweet(tweet)
  #     render(conn, "edit.html", tweet: tweet, changeset: changeset)
  #   end

  #   def update(conn, %{"id" => id, "tweet" => tweet_params}) do
  #     tweet = Tweets.get_tweet!(id)

  #     case Tweets.update_tweet(tweet, tweet_params) do
  #       {:ok, tweet} ->
  #         conn
  #         |> put_flash(:info, "Tweet updated successfully.")
  #         |> redirect(to: Routes.tweet_path(conn, :show, tweet))

  #       {:error, %Ecto.Changeset{} = changeset} ->
  #         render(conn, "edit.html", tweet: tweet, changeset: changeset)
  #     end
  #   end

  #   def delete(conn, %{"id" => id}) do
  #     tweet = Tweets.get_tweet!(id)
  #     {:ok, _tweet} = Tweets.delete_tweet(tweet)

  #     conn
  #     |> put_flash(:info, "Tweet deleted successfully.")
  #     |> redirect(to: Routes.tweet_path(conn, :index))
  #   end
end
