defmodule Githubstars.Repos.All do
  @moduledoc """
  Get all the starred repos of an user.
  """
  use Githubstars.Service

  alias Githubstars.Repos.Loader
  alias Githubstars.Repos.All.Params
  alias Githubstars.Core.{ErrorHandler, EctoUtils}

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params) do
      {:ok, Loader.all_by_user_id(request)}
    else
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end
end
