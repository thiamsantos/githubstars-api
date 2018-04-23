defmodule Githubstars.GithubClient.HTTPAdapter do
  @moduledoc """
  HTTP adapter for github client.
  """
  @behaviour Githubstars.GithubClient
  @github_oauth_token Application.get_env(:githubstars, :github_oauth_token)
  @headers [Authorization: "token #{@github_oauth_token}"]

  def get(path) do
    HTTPoison.get("https://api.github.com#{path}", @headers)
  end

  def head(path) do
    HTTPoison.head("https://api.github.com#{path}", @headers)
  end
end
