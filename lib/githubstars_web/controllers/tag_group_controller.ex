defmodule GithubstarsWeb.TagGroupController do
  use GithubstarsWeb, :controller

  alias Githubstars.Stars
  alias Githubstars.Stars.TagGroup

  action_fallback GithubstarsWeb.FallbackController

  def index(conn, _params) do
    tag_groups = Stars.list_tag_groups()
    render(conn, "index.json", tag_groups: tag_groups)
  end

  def create(conn, %{"tag_group" => tag_group_params}) do
    with {:ok, %TagGroup{} = tag_group} <- Stars.create_tag_group(tag_group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tag_group_path(conn, :show, tag_group))
      |> render("show.json", tag_group: tag_group)
    end
  end

  def show(conn, %{"id" => id}) do
    tag_group = Stars.get_tag_group!(id)
    render(conn, "show.json", tag_group: tag_group)
  end

  def update(conn, %{"id" => id, "tag_group" => tag_group_params}) do
    tag_group = Stars.get_tag_group!(id)

    with {:ok, %TagGroup{} = tag_group} <- Stars.update_tag_group(tag_group, tag_group_params) do
      render(conn, "show.json", tag_group: tag_group)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag_group = Stars.get_tag_group!(id)
    with {:ok, %TagGroup{}} <- Stars.delete_tag_group(tag_group) do
      send_resp(conn, :no_content, "")
    end
  end
end
