defmodule Githubstars.Repos.Show do
  @moduledoc """
  Get one repository starred by one user.
  """
  use Githubstars.Service

  alias Githubstars.Repos.Loader
  alias Githubstars.Repos.Show.Params
  alias Githubstars.Core.{ErrorHandler, EctoUtils, ErrorMessage}

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, repository} <- Loader.one_by_id(request) do
      {:ok, repository}
    else
      {:error, :repo_not_found} -> ErrorMessage.not_found("repository not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end
end
