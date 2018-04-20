defmodule GithubstarsWeb.UserController do
  use GithubstarsWeb, :controller

  alias Githubstars.Users

  action_fallback(GithubstarsWeb.FallbackController)

  def create(conn, params) do
    with {:ok, user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
