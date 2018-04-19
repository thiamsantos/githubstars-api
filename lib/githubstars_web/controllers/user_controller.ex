defmodule GithubstarsWeb.UserController do
  use GithubstarsWeb, :controller

  alias Githubstars.Users
  alias Githubstars.Users.User

  action_fallback(GithubstarsWeb.FallbackController)

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
