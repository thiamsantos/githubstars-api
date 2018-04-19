defmodule GithubstarsWeb.RepositoryController do
  use GithubstarsWeb, :controller

  alias Githubstars.Repos

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, _params) do
    repositories = Repos.list_repositories()
    render(conn, "index.json", repositories: repositories)
  end
end
