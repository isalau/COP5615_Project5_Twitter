defmodule TwitterWeb.RetweetController do
  use TwitterWeb, :controller

  def index(conn, params) do
    username = get_in(params, ["user_name"])
    IO.inspect(username, label: "I am starting THE PROCESS OF RETWEETING STEP1")
    render(conn, "index.html", username: username)
  end

  def retweet(conn, params) do
    sender = get_in(params, ["user_name"])
    num = get_in(params, ["tweet_num"])
    IO.puts("RETWEETING STEP 3")
    Retweet.re_tweet(sender, num)
    IO.puts("RETWEETING STEP 5")

    conn
    |> redirect(to: Routes.user_path(conn, :index, user_name: sender))
  end
end
