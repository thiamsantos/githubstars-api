defmodule Githubstars.Repos.All do
  @moduledoc """
  Get all the starred repos of an user.
  """
  use Githubstars.Service

  alias Githubstars.Repos.Loader
  alias Githubstars.Users.Loader, as: UsersLoader
  alias Githubstars.Repos.All.Params
  alias Githubstars.Core.{ErrorHandler, EctoUtils, ErrorMessage}

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, _user} <- UsersLoader.one_by_id(request.user_id) do
      {:ok, Loader.all_by_user_id(request)}
    else
      {:error, :user_not_found} -> ErrorMessage.not_found("user not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end
end
