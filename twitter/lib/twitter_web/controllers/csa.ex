defmodule CSA do
  use GenServer

  def start_link(name) do
    {:ok, _pid} =
      GenServer.start_link(__MODULE__, name,
        # Check - Haven't given any state to child except name
        name: :"#{name}"
      )

    # Check 2 - should we store one state eleme in tuple
  end

  def init(name) do
    # Trigger the CSSA

    {:ok, name}
  end

  def handle_call({:tweet, mssg}, _from, name) do
    Tweet.send_tweet(name, mssg)
    {:reply, :ok, name}
  end

  def handle_call({:subscribe, subs}, _from, name) do
    Subscribe.subscribe(name, subs)
    {:reply, :ok, name}
  end

  # def handle_call({:retweet}, _from, name) do
  #   # Retweet.retweet(name)
  #   {:reply, :ok, name}
  # end

  def handle_call({:hashtag, hashtag}, _from, name) do
    Query.get_hashtags(hashtag, name)
    {:reply, :ok, name}
  end

  def handle_call({:mention, mention}, _from, name) do
    Query.get_mentions(mention, name)
    {:reply, :ok, name}
  end

  def handle_call({:searching, query}, _from, name) do
    results = Query.get_my_results(query, name)
    {:reply, results, name}
  end
end
