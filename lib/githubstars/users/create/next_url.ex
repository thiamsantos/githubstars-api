defmodule Githubstars.Users.Create.NextUrl do
  @moduledoc """
  Get the next url by reading the HTTP header Link
  """

  def next_url(headers) do
    case ExLinkHeader.parse(Map.get(Map.new(headers), "Link", "")) do
      {:ok, link_header} -> parse_link_header(link_header)
      :error -> {:ok, :last_page}
    end
  end

  defp parse_link_header(link_header) do
    case Map.get(link_header, :next) do
      nil -> {:ok, :last_page}
      next_url -> {:ok, parse_next_link_url(next_url)}
    end
  end

  defp parse_next_link_url(next_url) do
    "#{next_url.path}?#{URI.encode_query(next_url.params)}"
  end
end
