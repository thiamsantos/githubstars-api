defmodule GithubstarsWeb.RepositoryView do
  use GithubstarsWeb, :view

  def render("index.json", %{repositories: repositories}) do
    %{
      data: render_many(repositories.entries, __MODULE__, "repository.json"),
      "_meta": render_one(repositories, __MODULE__, "meta.json"),
    }
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

  def render("meta.json", %{repository: repository}) do
    %{
      page_size: repository.page_size,
      page_number: repository.page_number,
      total_pages: repository.total_pages,
      total_entries: repository.total_entries
    }
  end
end
