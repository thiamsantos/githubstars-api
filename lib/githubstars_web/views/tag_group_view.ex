defmodule GithubstarsWeb.TagView do
  use GithubstarsWeb, :view
  alias GithubstarsWeb.TagView

  def render("index.json", %{tag_groups: tag_groups}) do
    render_many(tag_groups, TagView, "tag_group.json")
  end

  def render("show.json", %{tag_group: tag_group}) do
    %{
      id: tag_group.id,
      tags: tag_group.tags,
      user_id: tag_group.user_id,
      repository_id: tag_group.repository_id
    }
  end
end
