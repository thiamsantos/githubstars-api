defmodule GithubstarsWeb.RepositoryView do
  use GithubstarsWeb, :view

  def render("index.json", %{repositories: repositories}) do
    %{data: render_many(repositories, __MODULE__, "repository.json")}
  end

  def render("show.json", %{repository: repository}) do
    %{data: render_one(repository, __MODULE__, "repository.json")}
  end

  def render("repository.json", %{repository: repository}) do
    %{
      id: repository.id,
      name: repository.name,
      description: repository.description,
      url: repository.url,
      language: repository.language,
      github_id: repository.github_id
    }
  end
end
