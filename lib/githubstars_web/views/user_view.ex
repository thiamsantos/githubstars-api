defmodule GithubstarsWeb.UserView do
  use GithubstarsWeb, :view

  def render("show.json", %{user: user}) do
    %{id: user.id, name: user.name}
  end
end
