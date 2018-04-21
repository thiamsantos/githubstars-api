defmodule GithubstarsWeb.TagView do
  use GithubstarsWeb, :view

  def render("index.json", %{tags: tags}) do
    %{data: tags}
  end
end
