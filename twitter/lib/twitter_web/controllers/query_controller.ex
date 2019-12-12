defmodule TwitterWeb.QueryController do
  use TwitterWeb, :controller
  import TwitterWeb.UName

  alias Twitter.Querys
  alias Twitter.Querys.Query

  def index(conn, %{"user_name" => user_name} = params) do
    IO.inspect(user_name, label: "in add index")
    render(conn, "index.html", user_name: user_name)
    # query = get_in(params, ["query"])
    # user_name = get_in(params, ["user_name"])
    # IO.inspect(query, label: "#{user_name} in index")
    # # show results
    #
  end

  def test(conn, %{"user_name" => user_name} = params) do
    query = get_in(params, ["query"])
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

    render(conn, "index.html", user_name: user_name)
  end
end
