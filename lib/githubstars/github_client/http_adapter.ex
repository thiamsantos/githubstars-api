defmodule Githubstars.GithubClient.HTTPAdapter do
  @moduledoc """
  HTTP adapter for github client.
  """
  @behaviour Githubstars.GithubClient

  def get(path) do
    HTTPoison.get("https://api.github.com#{path}")
  end

  def head(path) do
    HTTPoison.head("https://api.github.com#{path}")
  end
end
