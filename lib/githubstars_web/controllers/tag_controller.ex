defmodule GithubstarsWeb.TagController do
  use GithubstarsWeb, :controller

  alias Githubstars.Tags

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, params) do
    with {:ok, tags} <- Tags.all(params) do
      render(conn, "index.json", tags: tags)
    end
  end

  def update(conn, params) do
    with {:ok, tags} <- Tags.update(params) do
      render(conn, "index.json", tags: tags)
    end
  end
end
