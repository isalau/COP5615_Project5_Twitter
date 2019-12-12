defmodule Query do
  def get_my_results(query, my_id) do
    IO.puts("in get my results")
    queryLength = String.length(query)

    if(queryLength == 0 || query == " ") do
      IO.puts("You cannot query an empty string")
      :EmptyQuery
    else
      id = :"#{my_id}_cssa"
      feedList = GenServer.call(id, {:get_feed})
      # IO.inspect(feedList, label: "feedList")

      # # for every value in the feedlist, search the tweet than search the username
      # # if something interesting is found append it to results
      #
      results = []

      results =
        for tweet <- feedList do
          _r =
            if(String.contains?(tweet, query) == true) do
              # IO.inspect(tweet, label: "Found")
              _results = results ++ tweet
            end
        end

      _results = List.flatten(Enum.filter(results, fn x -> x != nil end))
    end
  end

  def get_my_feed(my_id) do
    # Get the list of subscribers
    IO.puts("in get my feed")
    id = :"#{my_id}_cssa"
    {_, my_subscribed, _, _} = :sys.get_state(id)
    # Get each Subscribers tweets list and add it to my feed list
    # IO.inspect(my_subscribed, label: "These are the list of people i subscribed")

    for elem <- my_subscribed do
      # IO.inspect(elem, label: "Just checking if elem has _cssa in it")
      _d_tweets = []
      # elem = :"#{elem}_cssa"
      {_, _, _, d_tweets} = :sys.get_state(elem)
      # IO.inspect(d_tweets, label: "The tweets from #{elem}")
      {_, _, _d_feed, _} = GenServer.call(id, {:get_my_feed, d_tweets})
      # IO.inspect(d_feed, label: "Now my tweets have the feed of #{elem}")
    end
  end

  def get_hashtags(hashtag, my_id) do
    IO.puts("in get hashtags")
    pid = :"#{Engine}_cssa"
    id = :"#{my_id}_cssa"

    {_, people, _, _} = :sys.get_state(pid)
    people = people -- [my_id]
    # IO.inspect(people, label: "Total number of people who could have used this hashtag")
    # CHECK if elem is _cssa address

    for elem <- people do
      # get their tweets
      elem = :"#{elem}_cssa"
      {_, _, _, sent_tweets} = :sys.get_state(elem)
      # IO.inspect(sent_tweets)
      # check their tweets and collect their hashtags
      list_of_tweets =
        Enum.reduce(sent_tweets, [], fn x, lst ->
          if String.contains?(x, hashtag) do
            _lst = lst ++ [x]
          else
            _lst = lst
          end
        end)

      # IO.inspect(list_of_tweets, label: "The list of tweets that have the hashtag")
      # Get these hashtags in your feed using get_my_feed handle call
      if list_of_tweets != [] do
        # IO.puts("Putting the hashtags in your feed")
        {_, _, _, _d_feed} = GenServer.call(id, {:get_my_feed, list_of_tweets})
      end
    end
  end

  def get_mentions(mention, my_id) do
    IO.puts("in get mentions")
    pid = :"#{Engine}_cssa"
    id = :"#{my_id}_cssa"
    {_, people, _, _} = :sys.get_state(pid)
    people = people -- [id]

    for elem <- people do
      # get their tweets
      elem = :"#{elem}_cssa"
      {_, _, _, sent_tweets} = :sys.get_state(elem)
      # check their tweets and collect their hashtags
      list_of_tweets =
        Enum.reduce(sent_tweets, [], fn x, lst ->
          if String.contains?(x, mention) do
            _lst = lst ++ [x]
          else
            _lst = lst
          end
        end)

      # Get these hashtags in your feed using get_my_feed handle call
      {_, _, _, _d_feed} = GenServer.call(id, {:get_my_feed, list_of_tweets})
    end
  end
end
