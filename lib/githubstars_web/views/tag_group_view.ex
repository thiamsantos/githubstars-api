defmodule GithubstarsWeb.TagGroupView do
  use GithubstarsWeb, :view
  alias GithubstarsWeb.TagGroupView

  def render("index.json", %{tag_groups: tag_groups}) do
    %{data: render_many(tag_groups, TagGroupView, "tag_group.json")}
  end

  def render("show.json", %{tag_group: tag_group}) do
    %{data: render_one(tag_group, TagGroupView, "tag_group.json")}
  end

  def render("tag_group.json", %{tag_group: tag_group}) do
    %{id: tag_group.id,
      tags: tag_group.tags}
  end
end
