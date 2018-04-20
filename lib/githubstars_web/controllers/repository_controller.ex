defmodule GithubstarsWeb.RepositoryController do
  use GithubstarsWeb, :controller

  alias Githubstars.Repos

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, params) do
    with {:ok, repositories} <- Repos.list(params) do
      render(conn, "index.json", repositories: repositories)
    end
  end
end
