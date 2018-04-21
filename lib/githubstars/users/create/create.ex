defmodule Githubstars.Users.Create do
  @moduledoc """
  Create an user and save the starred repos.
  """
  use Githubstars.Service

  alias Githubstars.Users.{Mutator, User, Loader}
  alias Githubstars.Users.Create.Params
  alias Githubstars.Core.{ErrorHandler, ErrorMessage, EctoUtils}
  alias Githubstars.Users.Create.SaveRepos

  @github_client Application.get_env(:githubstars, :github_client)

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, true} <- username_exists?(request.name),
         {:ok, user} <- create_or_return(request.name) do
      {:ok, user}
    else
      {:error, :username_not_found} -> ErrorMessage.not_found("username not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end

  defp username_exists?(username) do
    case @github_client.head("/users/#{username}") do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        {:ok, true}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :username_not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp create_or_return(username) do
    with {:error, :user_not_found} <- Loader.one_by_name(username),
         {:ok, user} <- Mutator.create(username),
         :ok <- SaveRepos.save(user.name, user.id) do
      {:ok, user}
    else
      {:ok, %User{} = user} -> {:ok, user}
      {:error, reason} -> {:error, reason}
    end
  end
end
