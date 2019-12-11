defmodule Engine do
  use GenServer

  def start_link([followers, subscribed, feed, tweets, name]) do
    # new_name = name_cssa
    IO.puts("IN START ENGINE")

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
end
