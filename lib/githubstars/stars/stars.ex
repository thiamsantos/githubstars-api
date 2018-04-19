defmodule Githubstars.Stars do
  @moduledoc """
  The Stars context.
  """

  import Ecto.Query, warn: false
  alias Githubstars.Repo

  alias Githubstars.Stars.Repository
  alias Githubstars.Stars.TagGroup

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories do
    Repo.all(Repository)
  end

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single tag_group.

  Raises `Ecto.NoResultsError` if the Tag group does not exist.

  ## Examples

      iex> get_tag_group!(123)
      %TagGroup{}

      iex> get_tag_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag_group!(id), do: Repo.get!(TagGroup, id)

  @doc """
  Creates a tag_group.

  ## Examples

      iex> create_tag_group(%{field: value})
      {:ok, %TagGroup{}}

      iex> create_tag_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag_group(attrs \\ %{}) do
    %TagGroup{}
    |> TagGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag_group.

  ## Examples

      iex> update_tag_group(tag_group, %{field: new_value})
      {:ok, %TagGroup{}}

      iex> update_tag_group(tag_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag_group(%TagGroup{} = tag_group, attrs) do
    tag_group
    |> TagGroup.changeset(attrs)
    |> Repo.update()
  end
end
