defmodule Register do
  def reg(name, pass) do
    # start a process with the given name - CSA
    {_, tot_users, _, _} = :sys.get_state(:"#{Engine}_cssa")

    if name in tot_users do
      IO.puts("username already exists")
    else
      DySupervisor.start_child(name)

      # Start the CSSA
      tweets = []
      followers = []
      subscribed = []
      feed = []
      Engine.start_link([followers, subscribed, feed, tweets, name])

      # Get the name on subscribed list  lst
      # Get password name key word pair list in place of followers
      pid = :"#{Engine}_cssa"
      {new_key_pass, new_subscribed, _, _} = GenServer.call(pid, {:register, name, pass})
      # IO.inspect(new_key_pass, label: "The key pass list is")
      # IO.inspect(new_subscribed, label: "The people's list is")
      {new_key_pass, new_subscribed}
    end
  end

  def children do
    {_, names, _, _} = :sys.get_state(:"#{Engine}_cssa")

    # for elem <- names do
    #   id = :"#{elem}_cssa"
    #   pid = GenServer.whereis(id)

    #   if Process.alive?(pid) do
    #     IO.inspect(elem, label: "Running")
    #   end
    # end

    names
  end

  def makeKids(num, _pass) when num > 1 do
    # start a child
    numm = Integer.to_string(num)
    username = String.replace_suffix("child x", " x", numm)
    reg(username, "pwd")
    newNum = num - 1
    makeKids(newNum, "pwd")
  end

  def makeKids(num, _pass) do
    # start a child
    numm = Integer.to_string(num)
    username = String.replace_suffix("child x", " x", numm)
    reg(username, "pwd")
  end
end
