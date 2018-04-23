defmodule GithubstarsWeb.RepositoryController do
  use GithubstarsWeb, :controller

  alias Githubstars.Repos

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, params) do
    conn = fetch_query_params(conn)

    tag = Map.get(conn.query_params, "tag", "")
    params = Map.put(params, "tag", tag)

    with {:ok, repositories} <- Repos.all(params) do
      render(conn, "index.json", repositories: repositories)
    end
  end

  def show(conn, params) do
    with {:ok, repository} <- Repos.show(params) do
      render(conn, "show.json", repository: repository)
    end
  end
end
