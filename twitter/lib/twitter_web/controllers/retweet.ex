defmodule Retweet do
  def re_tweet(sender, num) do
    id = :"#{sender}_cssa"
    {_, _, my_feed, _} = :sys.get_state(id)

    _c = 0
    _lst = []
    my_feed = ["HEY", "YOU"]

    {_, my_new_feed} =
      Enum.reduce(my_feed, {0, []}, fn x, {c, lst} ->
        c = c + 1
        lst = lst ++ [{:"#{c}", x}]
        {c, lst}
      end)

    re_tweet_n = num
    select = :"#{re_tweet_n}"
    # Not checked if this works
    # IO.inspect(select, label: "You Selected #{select}")
    tweet = List.keyfind(my_new_feed, select, 0)

    if tweet != nil do
      tweet = elem(tweet, 1)
      newTweet = "#I am retweeting: tweet #{tweet}"
      # IO.inspect(tweet, label: "You Selected this tweet")
      IO.puts("RETWEETING STEP 4.1")
      GenServer.call(id, {:tweet, newTweet})
      IO.puts("RETWEETING STEP 4.2")
    else
      # IO.puts("can't find the tweet you want to retweet")
    end
  end
end
