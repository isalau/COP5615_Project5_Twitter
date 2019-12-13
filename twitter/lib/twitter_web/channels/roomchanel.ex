defmodule TwitterWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> _room, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
