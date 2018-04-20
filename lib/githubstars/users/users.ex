defmodule Githubstars.Users do
  @moduledoc """
  Users context.
  """
  alias Githubstars.Users.Create

  def create(params), do: Create.call(params)
end
