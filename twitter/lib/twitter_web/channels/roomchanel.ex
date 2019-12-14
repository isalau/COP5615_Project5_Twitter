defmodule TwitterWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> room_id, _params, socket) do
    {:ok, %{channel: "room:#{room_id}"}, assign(socket, :room_id, room_id)}
  end

  def handle_in("message:add", %{"message" => content}, socket) do
    room_id = socket.assigns[:room_id]
    IO.inspect("IN HANDLE IN")
    IO.inspect(content, label: "#{room_id} sending")
    Tweet.send_tweet2(room_id, content)

    broadcast!(socket, "room:#{room_id}:new_message", %{content: content})
    IO.puts("broadcasted everything")
    {:reply, :ok, socket}
  end

  def handle_in("message:retweet", %{"message" => content}, socket) do
    room_id = socket.assigns[:room_id]
    IO.puts("IN RETWEET HANDLE IN - Step 3")
    # IO.inspect(content, label: "#{room_id} sending")
    tweet = Retweet.re_tweet(room_id, content)
    IO.inspect(tweet, label: "The tweet im retweeting")
    justTweet = elem(tweet, 1)
    broadcast!(socket, "room:#{room_id}:new_message", %{content: justTweet})
    IO.puts("broadcasted everything")
    {:reply, :ok, socket}
  end
end
