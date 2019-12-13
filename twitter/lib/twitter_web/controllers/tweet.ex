defmodule Tweet do
  def send_tweet(sender, tweet, conn) do
    # Tell the process of sender about the tweet
    pid_sender = :"#{sender}_cssa"
    tweetLength = String.length(tweet)

    if(tweetLength > 280) do
      overby = tweetLength - 280
      IO.puts("Tweet is too long by #{overby} characters please try again. ")
      :TweetToLong
    else
      if(tweetLength == 0 || tweet == " ") do
        IO.puts("You cannot tweet an empty string")
        :EmptyTweet
      else
        tweetnname = "#{tweet} - #{sender}"
        new_tweets = GenServer.call(pid_sender, {:tweet, tweetnname, conn})
        # IO.inspect(new_tweets, label: "#{sender} has tweeted")
        new_tweets
      end
    end
  end

  def send_tweet2(sender, tweet) do
    IO.puts("IN SEND TWEET 2")
    # Tell the process of sender about the tweet
    pid_sender = :"#{sender}_cssa"
    tweetLength = String.length(tweet)

    if(tweetLength > 280) do
      overby = tweetLength - 280
      IO.puts("Tweet is too long by #{overby} characters please try again. ")
      :TweetToLong
    else
      if(tweetLength == 0 || tweet == " ") do
        IO.puts("You cannot tweet an empty string")
        :EmptyTweet
      else
        tweetnname = "#{tweet} - #{sender}"
        new_tweets = GenServer.call(pid_sender, {:tweet2, tweetnname})
        # IO.inspect(new_tweets, label: "#{sender} has tweeted")
        new_tweets
      end
    end
  end

  def distribute_it(tweet, people, conn) do
    # Tell the engine to distribute the tweet
    # pid = :"#{Engine}_cssa"
    # :ok = GenServer.call(pid, {:distribute, tweet, people})
    for elem <- people do
      pid = :"#{elem}"
      _feed = GenServer.call(pid, {:got_mssg, tweet, conn, pid})
      # IO.inspect(feed, label: "My #{elem} news feeds after getting the tweet")
    end
  end

  def distribute_it2(tweet, people) do
    IO.puts("In distribute it 2")
    # Tell the engine to distribute the tweet
    # pid = :"#{Engine}_cssa"
    # :ok = GenServer.call(pid, {:distribute, tweet, people})
    for elem <- people do
      pid = :"#{elem}"
      _feed = GenServer.call(pid, {:got_mssg2, tweet})
      # IO.inspect(feed, label: "My #{elem} news feeds after getting the tweet")
    end
  end

  # end

  def sendManyTweets(num, tweets_db) do
    # for every user
    pid = :"#{Engine}_cssa"
    all_users = GenServer.call(pid, {:getAllUsers})

    for user <- all_users do
      # send num amount of tweets
      simtweet(user, num, tweets_db)
    end
  end

  def simtweet(user, num, tweets_db) when num > 1 do
    # IO.puts("#{user} sending tweet")
    pid_user = :"#{user}"
    # from tweets_db
    numOfTweetsInDb = length(tweets_db)

    if num < numOfTweetsInDb do
      tweet = Enum.at(tweets_db, num)
      Tweet.send_tweet2(pid_user, tweet)
      # GenServer.call(pid_user, {:tweet, tweet})
    else
      mod = Integer.mod(num, numOfTweetsInDb)
      tweet = Enum.at(tweets_db, mod)
      Tweet.send_tweet2(pid_user, tweet)
      # GenServer.call(pid_user, {:tweet, tweet})
    end

    num = num - 1
    simtweet(user, num, tweets_db)
  end

  def simtweet(user, num, tweets_db) do
    # IO.puts("#{user} sending tweet")
    pid_user = :"#{user}"
    # from tweets_db
    numOfTweetsInDb = length(tweets_db)

    if num < numOfTweetsInDb do
      tweet = Enum.at(tweets_db, num)
      GenServer.call(pid_user, {:tweet2, tweet})
    else
      mod = Integer.mod(num, numOfTweetsInDb)
      tweet = Enum.at(tweets_db, mod)
      GenServer.call(pid_user, {:tweet2, tweet})
    end
  end
end
