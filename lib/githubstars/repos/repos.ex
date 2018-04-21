defmodule Githubstars.Repos do
  @moduledoc """
  Repos context.
  """
  alias Githubstars.Repos.All

  def all(params), do: All.call(params)
end
