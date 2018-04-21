defmodule Githubstars.Repos do
  @moduledoc """
  Repos context.
  """
  alias Githubstars.Repos.{All, Save}

  def all(params), do: All.call(params)
  def save(params), do: Save.call(params)
end
