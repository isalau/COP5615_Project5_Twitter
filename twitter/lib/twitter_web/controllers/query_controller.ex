defmodule TwitterWeb.QueryController do
  use TwitterWeb, :controller
  import TwitterWeb.UName

  alias Twitter.Querys
  alias Twitter.Querys.Query

  def index(conn, params) do
    user_name = get_in(params, ["user_name"])
    results = get_in(params, ["results"])
    IO.inspect(user_name, label: "In Query user_name")
    IO.inspect(results, label: "In Query results")
    render(conn, "index.html", user_name: user_name, results: results)
  end

  def test(conn, %{"user_name" => user_name} = params) do
    query = get_in(params, ["query"])
    pid_sender = :"#{user_name}"

    # person
    r =
      if String.contains?(query, "@") do
        mention = query
        GenServer.call(pid_sender, {:mention, mention})
      else
        # hashtag
        results =
          if String.contains?(query, "#") do
            hashtag = query
            GenServer.call(pid_sender, {:hashtag, hashtag})
          else
            # word or phrase
            GenServer.call(pid_sender, {:searching, query})
          end
      end

    IO.inspect(r, label: "results")
    # |> redirect("index.html", %{user_name: user_name, results: r})
    conn
    |> redirect(to: Routes.query_path(conn, :index, user_name: user_name, results: r))
  end
end
