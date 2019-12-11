defmodule Delete do
  def deleteUser(id) do
    # IO.inspect(state, label: "State")
    # answer = Mix.Shell.IO.prompt("Are you sure you would like to delete your account?")
    # answer = String.trim(IO.gets("Are you sure you would like to delete your account?"))

    # case answer do
    #   "Yes" ->
    # if checkPassword passes
    userName = id
    # password = Enum.at(state, 1)
    # enteredpassword1 = Mix.Shell.IO.prompt("Please Enter Your Password:")
    # enteredpassword = String.trim(enteredpassword1)

    # if password == enteredpassword do
    deleteConfirm(userName)

    # else
    #   IO.puts("Incorrect password")
    # end

    # "yes" ->
    #   # if checkPassword passes
    #   userName = id
    #   # password = Enum.at(state, 1)
    #   # enteredpassword1 = Mix.Shell.IO.prompt("Please Enter Your Password:")
    #   # enteredpassword = String.trim(enteredpassword1)
    #
    #   # if password == enteredpassword do
    #   deleteConfirm(userName)
    #
    #   # else
    #   #   IO.puts("Incorrect password")
    #   # end
    #
    #   # "No\n" ->
    #   #   showMainMenu(state)
    #   #
    #   # "no\n" ->
    #   #   showMainMenu(state)
    # end
  end

  def deleteConfirm(id) do
    # confirm = Mix.Shell.IO.prompt("Final confirmation. Delete Account?")
    # confirm = String.trim(IO.gets("Are you sure you would like to delete your account?"))
    #
    # case confirm do
    #   "Yes" ->
    # delete from supervisor and log out
    # deleteFromSupervisor(state)
    remAsfollower(id)
    remFromEngine(id)
    deleteFromCSA(id)

    # deleteFromCSSA(id)

    #   "yes" ->
    #     # deleteFromSupervisor(state)
    #     remAsfollower(id)
    #     remFromEngine(id)
    #     deleteFromCSA(id)
    #     # deleteFromCSSA(id)
    #
    #     # "No\n" ->
    #     #   showMainMenu(state)
    #     #
    #     # "no\n" ->
    #     #   showMainMenu(state)
    # end
  end

  def deleteFromCSA(id) do
    dpid = Process.whereis(DySupervisor)
    # # val = Process.alive?(dpid)
    # userName = Enum.at(state, 0)
    pid = GenServer.whereis(id)
    # IO.inspect(pid, label: "deleting child")
    DynamicSupervisor.terminate_child(dpid, pid)
    # IO.puts("Account Deleted From Supervisor.")
  end

  def deleteFromCSSA(id) do
    id = :"#{id}_cssa"
    Process.register(self(), :test)
    _mpid = Process.whereis(:test)
    # IO.inspect(mpid, label: "I am ")
    pid = GenServer.whereis(id)
    # IO.inspect(pid, label: "Going to kill the CSSA ")
    send(pid, :kill_me_pls)
    bool_al = Process.alive?(pid)
    # IO.inspect(bool_al, label: "Is process alive")

    if bool_al do
      # IO.puts("Still alive")
    else
      # IO.puts("Process deleted from CSSA")
    end
  end

  def remAsfollower(id) do
    id = :"#{id}_cssa"
    {_, my_subscribed, _, _} = :sys.get_state(id)

    for elem <- my_subscribed do
      # elem = :"#{elem}_cssa"
      followers = GenServer.call(elem, {:Remove_me, id})
      # IO.inspect(followers, label: "My #{elem} followers list")
      followers
    end
  end

  def remFromEngine(id) do
    pid = :"#{Engine}_cssa"
    # id = :"#{id}_cssa"
    {new_key_pass, new_subscribed, _, _} = GenServer.call(pid, {:Unregister, id})
    # IO.inspect(new_key_pass, label: "Engine's key_pass list")
    # IO.inspect(new_subscribed, label: "Engine's subscribed after deleting ")
    {new_key_pass, new_subscribed}
  end
end
