defmodule Engine do
  use GenServer

  def start_link([followers, subscribed, feed, tweets, name]) do
    # new_name = name_cssa
    {:ok, _pid} =
      GenServer.start_link(__MODULE__, {followers, subscribed, feed, tweets},
        name: :"#{name}_cssa"
      )
  end

  def init(_init_arg) do
    tweets = []
    followers = []
    subscribed = []
    feed = []
    {:ok, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:register, name, pass}, _from, {followers, subscribed, feed, tweets}) do
    subscribed = subscribed ++ [name]
    followers = followers ++ [{:"#{name}", pass}]
    # Register.get_people(name,people)#HERE everyone is on everyone's list
    {:reply, {followers, subscribed, feed, tweets}, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:Unregister, name}, _from, {followers, subscribed, feed, tweets}) do
    nm = Atom.to_string(name)
    subscribed = subscribed -- [nm]
    followers = List.keydelete(followers, name, 0)
    # Register.get_people(name,people)#HERE everyone is on everyone's list
    {:reply, {followers, subscribed, feed, tweets}, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:Remove_me, follower}, _from, {followers, subscribed, feed, tweets}) do
    followers = followers -- [follower]
    {:reply, followers, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:getAllUsers}, _from, {followers, subscribed, feed, tweets}) do
    subscribed = subscribed
    {:reply, subscribed, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:tweet, tweet, conn}, _from, {followers, subscribed, feed, tweets}) do
    tweets = tweets ++ [tweet]
    # followers = followers ++ ["ab_cssa"]

    if followers != [] do
      # IO.puts("Im distributing tweets")
      Tweet.distribute_it(tweet, followers, conn)
    end

    {:reply, tweets, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:tweet2, tweet}, _from, {followers, subscribed, feed, tweets}) do
    tweets = tweets ++ [tweet]
    # followers = followers ++ ["ab_cssa"]

    if followers != [] do
      # IO.puts("Im distributing tweets")
      Tweet.distribute_it2(tweet, followers)
    end

    {:reply, tweets, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:get_my_tweets}, _from, {followers, subscribed, feed, tweets}) do
    tweets = tweets

    {:reply, tweets, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:got_mssg, tweet, conn, user}, _from, {followers, subscribed, feed, tweets}) do
    feed = feed ++ [tweet]
    # pid = self()
    # IO.puts("My tweets are ")
    # IO.inspect(tweets)
    # TwitterWeb.TweetController.got_mssg(conn, user)
    {:reply, feed, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:got_mssg2, tweet}, _from, {followers, subscribed, feed, tweets}) do
    feed = feed ++ [tweet]
    # pid = self()
    # IO.puts("My tweets are ")
    # IO.inspect(tweets)
    {:reply, feed, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:populate, follower}, _from, {followers, subscribed, feed, tweets}) do
    followers = followers ++ [follower]
    {:reply, {followers, subscribed, feed, tweets}, {followers, subscribed, feed, tweets}}
  end

  def handle_call(
        {:subscribed, following, new_tweets},
        _from,
        {followers, subscribed, feed, tweets}
      ) do
    subscribed = subscribed ++ [following]
    feed = feed ++ new_tweets
    {:reply, {followers, subscribed, feed, tweets}, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:get_feed}, _from, {followers, subscribed, feed, tweets}) do
    {:reply, feed, {followers, subscribed, feed, tweets}}
  end

  def handle_call({:get_my_feed, new_feed}, _from, {followers, subscribed, feed, tweets}) do
    feed = feed ++ new_feed
    # IO.inspect(feed, label: "The feed now inside looks like")
    # IO.inspect(tweets, label: "The tweets inside look like")
    {:reply, {followers, subscribed, feed, tweets}, {followers, subscribed, feed, tweets}}
  end

  def handle_info(:kill_me_pls, {followers, subscribed, feed, tweets}) do
    # IO.puts("Inside Killing myself")
    {:stop, :normal, {followers, subscribed, feed, tweets}}
  end

  def terminate(_, {_followers, _subscribed, _feed, _tweets}) do
    # IO.inspect("Look! I'm dead.")
  end
end
