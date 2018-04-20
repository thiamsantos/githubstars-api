defmodule Githubstars.GithubClient do
  @moduledoc """
  Github API client.
  """
  @callback get(String.t()) :: {:ok, HTTPoison.Response.t()}
end
