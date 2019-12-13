defmodule TwitterWeb.RetweetView do
  use TwitterWeb, :view

  def get_retweet(username) do
    id = :"#{username}_cssa"
    IO.inspect(id, label: "THE NEXT STEP 2")
    {_, _, my_feed, _} = :sys.get_state(id)
    # convert the list to a keyword list
    _c = 0
    _lst = []
    # my_feed = ["HEY", "YOU"]

    # {_, my_new_feed} =
    #   Enum.reduce(my_feed, {0, []}, fn x, {c, lst} ->
    #     c = c + 1
    #     lst = lst ++ [{:"#{c}", x}]
    #     {c, lst}
    #   end)

    my_feed = my_feed
  end
end
