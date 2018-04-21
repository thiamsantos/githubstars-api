defmodule Githubstars.Tags do
  @moduledoc """
  Tags context.
  """

  alias Githubstars.Tags.{Update, All}

  def update(params), do: Update.call(params)
  def all(params), do: All.call(params)
end
