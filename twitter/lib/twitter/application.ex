defmodule Twitter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Twitter.Repo,
      # Start the endpoint when the application starts
      TwitterWeb.Endpoint
      # Starts a worker by calling: Twitter.Worker.start_link(arg)
      # {Twitter.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options

    DySupervisor.start_link(1)
    # Start the engine \
    tweets = []
    followers = []
    subscribed = []
    feed = []
    {:ok, _pid} = Engine.start_link([followers, subscribed, feed, tweets, Engine])
    runSimulation(5, 5)
    opts = [strategy: :one_for_one, name: Twitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def runSimulation(num_user, num_msg) do
    # get number of users --> makeKids(numUsers)
    Register.makeKids(num_user, "pwd")
    # get number of fake tweets --> makeFakeTweets(numTweets)
    testTweets_db = []
    testTweets = makeFakeTweets(num_msg, testTweets_db)
    # subscribe
    Subscribe.subscribeMany(num_user)
    # IO.inspect(testTweets, label: "test Tweets")
    Tweet.sendManyTweets(num_msg, testTweets)

    # sends that many tweets per user
    # re-tweet
    # query
    # feed
  end

  def makeFakeTweets(num, testTweets_db) when num > 1 do
    numm = Integer.to_string(num)
    numtweet = String.replace_suffix("tweet x", " x", numm)
    testTweet = "Test #{numtweet}"
    testTweets_db = testTweets_db ++ [testTweet]
    newNum = num - 1
    makeFakeTweets(newNum, testTweets_db)
  end

  def makeFakeTweets(num, testTweets_db) do
    numm = Integer.to_string(num)
    numtweet = String.replace_suffix("tweet x", " x", numm)
    testTweet = "Test #{numtweet}"
    _testTweets_db = testTweets_db ++ [testTweet]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TwitterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
