defmodule Githubstars.Repos do
  @moduledoc """
  Repos context.
  """
  alias Githubstars.Repos.{All, Save, Show}

  def all(params), do: All.call(params)
  def save(params), do: Save.call(params)
  def show(params), do: Show.call(params)
end
