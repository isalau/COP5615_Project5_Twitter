defmodule TwitterWeb.QueryController do
  use TwitterWeb, :controller

  alias Twitter.Querys
  alias Twitter.Querys.Query

  def index(conn, %{"user_name" => user_name} = params) do
    # querys = Querys.list_querys()
    render(conn, "index.html", user_name: user_name)
  end

  def query(conn, %{"user_name" => user_name} = params) do
    query = get_in(params, ["toSearch"])
    IO.inspect(query, label: "In query")
    pid_sender = :"#{user_name}"

    # person
    if String.contains?(query, "@") do
      mention = query
      GenServer.call(pid_sender, {:mention, mention})
    else
      # hashtag
      if String.contains?(query, "#") do
        hashtag = query
        GenServer.call(pid_sender, {:hashtag, hashtag})
      else
        # word or phrase
        GenServer.call(pid_sender, {:searching, query})
      end
    end

    render(conn, "index.html")
  end
end
