defmodule Githubstars.Repos do
  @moduledoc """
  Repos context.
  """
  alias Githubstars.Repos.List

  def list(params), do: List.call(params)
end
