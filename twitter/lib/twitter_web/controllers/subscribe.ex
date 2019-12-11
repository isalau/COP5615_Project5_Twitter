defmodule Subscribe do
  def subscribe(from, to) do
    # Populate people's list (PLUG)
    # IO.puts("Lets start subscribin !")
    pid_from = :"#{from}_cssa"
    pid_to = :"#{to}_cssa"

    # Put your name in the followers list of the person followed
    {new_followers, _, _, new_tweets} = GenServer.call(pid_to, {:populate, pid_from})

    # IO.inspect(new_followers,
    #   label: "The followers in the person you subscribed to has your name !"
    # )

    # Put their name in your subscribed list
    {_, new_subscribed, _, _} = GenServer.call(pid_from, {:subscribed, pid_to, new_tweets})
    # IO.inspect(new_subscribed, label: "you have subscribed to #{to}")
    {new_followers, new_subscribed}
  end

  def subscribeMany(num_user) do
    # for every user
    pid = :"#{Engine}_cssa"
    all_users = GenServer.call(pid, {:getAllUsers})

    for user <- all_users do
      # pick a random number of people to subscribe too
      # numToSub = Enum.random(1..num_user)
      numToSub = 2
      subRandom(user, numToSub, num_user)
    end
  end

  def subRandom(user, numOfSub, num_user) when numOfSub > 1 do
    # pick a random person to subscribe to
    pid = :"#{Engine}_cssa"
    all_users = GenServer.call(pid, {:getAllUsers})
    num_end = num_user - 1
    numToSub = Enum.random(0..num_end)
    subs = Enum.at(all_users, numToSub)
    # IO.puts("#{user} pick #{numToSub} from the hat wants to subscribe to #{subs}")

    if user != subs do
      pid_sender2 = :"#{user}"
      GenServer.call(pid_sender2, {:subscribe, subs})
    end

    # pid_sender = :"#{user}"
    # GenServer.call(pid_sender, {:subscribe, subs})

    numOfSub = numOfSub - 1
    subRandom(user, numOfSub, num_user)
  end

  def subRandom(user, _numOfSub, num_user) do
    pid = :"#{Engine}_cssa"
    all_users = GenServer.call(pid, {:getAllUsers})
    num_end = num_user - 1
    numToSub = Enum.random(0..num_end)
    subs = Enum.at(all_users, numToSub)
    # IO.puts("#{user} pick #{numToSub} from the hat wants to subscribe to #{subs}")
    if user != subs do
      pid_sender2 = :"#{user}"
      GenServer.call(pid_sender2, {:subscribe, subs})
    end
  end
end
