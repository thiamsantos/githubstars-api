defmodule GithubstarsWeb.RepositoryController do
  use GithubstarsWeb, :controller

  alias Githubstars.Stars
  alias Githubstars.Stars.Repository

  action_fallback(GithubstarsWeb.FallbackController)

  def index(conn, _params) do
    repositories = Stars.list_repositories()
    render(conn, "index.json", repositories: repositories)
  end

  def create(conn, %{"repository" => repository_params}) do
    with {:ok, %Repository{} = repository} <- Stars.create_repository(repository_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", repository_path(conn, :show, repository))
      |> render("show.json", repository: repository)
    end
  end

  def show(conn, %{"id" => id}) do
    repository = Stars.get_repository!(id)
    render(conn, "show.json", repository: repository)
  end

  def update(conn, %{"id" => id, "repository" => repository_params}) do
    repository = Stars.get_repository!(id)

    with {:ok, %Repository{} = repository} <-
           Stars.update_repository(repository, repository_params) do
      render(conn, "show.json", repository: repository)
    end
  end

  def delete(conn, %{"id" => id}) do
    repository = Stars.get_repository!(id)

    with {:ok, %Repository{}} <- Stars.delete_repository(repository) do
      send_resp(conn, :no_content, "")
    end
  end
end
