defmodule Githubstars.Repos.List do
  use Githubstars.Service

  alias Githubstars.Repos.Loader

  def run(params) do
    {:ok, Loader.list_all_by_user_id(params["user_id"])}
  end
end
