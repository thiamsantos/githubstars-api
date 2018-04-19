defmodule Githubstars.Core.ErrorMessage do
  @moduledoc """
  Error message builder
  """
  def create(type, message) do
    {:error, {type, message}}
  end

  def not_found(message) do
    create(:not_found, %{"message" => message})
  end

  def validation(error) when is_binary(error), do: create(:validation, error)

  def validation(error) when is_list(error), do: create(:validation, error)

  def validation(field, type, message) do
    create(:validation, %{"field" => field, "type" => type, "message" => message})
  end
end
