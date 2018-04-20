defmodule GithubstarsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use GithubstarsWeb, :controller

  alias GithubstarsWeb.Explode

  def call(conn, {:error, {type, errors}}) do
    conn
    |> Explode.reply(type, errors)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> Explode.not_found()
  end
end
