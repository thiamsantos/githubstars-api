defmodule GithubstarsWeb.UserView do
  use GithubstarsWeb, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name}
  end
end
