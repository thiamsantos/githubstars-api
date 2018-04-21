defmodule Githubstars.Tags.Update do
  @moduledoc """
  Update the tags associated with a starred repository.
  """
  use Githubstars.Service

  alias Githubstars.Tags.Mutator
  alias Githubstars.Tags.Update.Params
  alias Githubstars.Core.{ErrorHandler, ErrorMessage, EctoUtils}

  def run(params) do
    with {:ok, request} <- EctoUtils.validate(Params, params),
         {:ok, tags} <- Mutator.update_tags(request) do
      {:ok, tags}
    else
      {:error, :tag_group_not_found} -> ErrorMessage.not_found("tags not found")
      {:error, reason} -> ErrorHandler.handle(reason)
    end
  end
end
