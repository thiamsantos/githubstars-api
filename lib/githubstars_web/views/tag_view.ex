defmodule GithubstarsWeb.TagView do
  use GithubstarsWeb, :view

  def render("index.json", %{tags: tags}) do
    tags
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
