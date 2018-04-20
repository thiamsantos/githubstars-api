defmodule GithubstarsWeb.Router do
  use GithubstarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubstarsWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create] do
      resources "/repos", RepositoryController, only: [:index]
    end
  end
end
