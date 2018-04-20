defmodule Githubstars.GithubClient.HTTPAdapter do
  @moduledoc """
  HTTP adapter for github client.
  """
  @behaviour Githubstars.GithubClient

  def get(url) do
    HTTPoison.get("https://api.github.com#{url}")
  end
end
