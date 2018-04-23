defmodule GithubstarsWeb.Router do
  use GithubstarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", GithubstarsWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create] do
      resources "/repos", RepositoryController, only: [:index, :show] do
        resources "/tags", TagController, only: [:update], singleton: true
        resources "/tags", TagController, only: [:index]
      end
    end
  end
end
