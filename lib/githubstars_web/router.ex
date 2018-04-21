defmodule GithubstarsWeb.Router do
  use GithubstarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubstarsWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create] do
      resources "/repos", RepositoryController, only: [:index] do
        resources "/tags", TagController, only: [:index]
        resources "/tags", TagController, only: [:update], singleton: true
      end
    end
  end
end
