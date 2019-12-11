defmodule Main do
  def main_task do
    # Start the supervisor \
    DySupervisor.start_link(1)
    # Start the engine \
    tweets = []
    followers = []
    subscribed = []
    feed = []
    {:ok, _pid} = Engine.start_link([followers, subscribed, feed, tweets, Engine])
  end
end
