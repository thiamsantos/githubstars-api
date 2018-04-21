defmodule Githubstars.Tags.All do
  @moduledoc """
  Get all the tags associated with a given repository.
  """
  use Githubstars.Service

  alias Githubstars.Tags.Loader
  alias Githubstars.Tags.All.Params
  alias Githubstars.Core.{ErrorHandler, ErrorMessage, EctoUtils}

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, tags} <- Loader.get_tags(request) do
      {:ok, tags}
    else
      {:error, :tags_not_found} -> ErrorMessage.not_found("tags not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end
end
