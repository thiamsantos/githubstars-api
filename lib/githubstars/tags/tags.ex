defmodule Githubstars.Tags do
  @moduledoc """
  Tags context.
  """

  alias Githubstars.Tags.{Update, List}

  def update(params), do: Update.call(params)
  def list(params), do: List.call(params)
end
