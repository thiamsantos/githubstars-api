defmodule GithubstarsWeb.TagController do
  use GithubstarsWeb, :controller

  alias Githubstars.Tags

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, params) do
    with {:ok, tags} <- Tags.list(params) do
      render(conn, "index.json", tags: tags)
    end
  end

  def update(conn, params) do
    with {:ok, tag_group} <- Tags.update(params) do
      render(conn, "show.json", tag_group: tag_group)
    end
  end
end
