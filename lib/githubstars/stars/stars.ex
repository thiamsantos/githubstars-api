defmodule Githubstars.Stars do
  @moduledoc """
  The Stars context.
  """

  import Ecto.Query, warn: false
  alias Githubstars.Repo

  alias Githubstars.Stars.Repository

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
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id), do: Repo.get!(Repository, id)

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
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> Repository.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{source: %Repository{}}

  """
  def change_repository(%Repository{} = repository) do
    Repository.changeset(repository, %{})
  end

  alias Githubstars.Stars.TagGroup

  @doc """
  Returns the list of tag_groups.

  ## Examples

      iex> list_tag_groups()
      [%TagGroup{}, ...]

  """
  def list_tag_groups do
    Repo.all(TagGroup)
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

  @doc """
  Deletes a TagGroup.

  ## Examples

      iex> delete_tag_group(tag_group)
      {:ok, %TagGroup{}}

      iex> delete_tag_group(tag_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag_group(%TagGroup{} = tag_group) do
    Repo.delete(tag_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag_group changes.

  ## Examples

      iex> change_tag_group(tag_group)
      %Ecto.Changeset{source: %TagGroup{}}

  """
  def change_tag_group(%TagGroup{} = tag_group) do
    TagGroup.changeset(tag_group, %{})
  end
end
