defmodule GithubstarsWeb.RepositoryView do
  use GithubstarsWeb, :view

  def render("index.json", %{repositories: repositories}) do
    render_many(repositories, __MODULE__, "show.json")
  end

  def render("show.json", %{repository: repository}) do
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
