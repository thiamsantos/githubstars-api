defmodule Githubstars.GithubClient do
  @moduledoc """
  Github API client.
  """
  @callback get(String.t()) ::
              {:ok, HTTPoison.Response.t()}
              | {:error, HTTPoison.Error.t()}
  @callback head(String.t()) ::
              {:ok, HTTPoison.Response.t()}
              | {:error, HTTPoison.Error.t()}
end
