defmodule GithubstarsWeb.TagGroupController do
  use GithubstarsWeb, :controller

  alias Githubstars.Repos
  alias Githubstars.Repos.TagGroup

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, _params) do
    tag_groups = Repos.list_tag_groups()
    render(conn, "index.json", tag_groups: tag_groups)
  end

  def update(conn, %{"id" => id, "tag_group" => tag_group_params}) do
    tag_group = Repos.get_tag_group!(id)

    with {:ok, %TagGroup{} = tag_group} <- Repos.update_tag_group(tag_group, tag_group_params) do
      render(conn, "show.json", tag_group: tag_group)
    end
  end
end
