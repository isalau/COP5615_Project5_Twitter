defmodule TwitterWeb.PageController do
  use TwitterWeb, :controller

  def index(conn, _params) do
    DySupervisor.start_link(1)
    # Start the engine \
    tweets = []
    followers = []
    subscribed = []
    feed = []
    {:ok, _pid} = Engine.start_link([followers, subscribed, feed, tweets, Engine])
    render(conn, "index.html")
  end
end
