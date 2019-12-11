defmodule CSA do
  use GenServer

  def start_link(name) do
    {:ok, _pid} =
      GenServer.start_link(__MODULE__, name,
        # Check - Haven't given any state to child except name
        name: :"#{name}"
      )

    # Check 2 - should we store one state eleme in tuple
  end

  def init(name) do
    # Trigger the CSSA

    {:ok, name}
  end
end
