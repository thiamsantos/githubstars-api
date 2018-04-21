defmodule GithubstarsWeb.RepositoryController do
  use GithubstarsWeb, :controller

  alias Githubstars.Repos

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, params) do
    conn = fetch_query_params(conn)

    tag = Map.get(conn.query_params, :tag, "")
    params = Map.put(params, "tag", tag)

    with {:ok, repositories} <- Repos.list(params) do
      render(conn, "index.json", repositories: repositories)
    end
  end
end
