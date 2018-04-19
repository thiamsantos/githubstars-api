defmodule Githubstars.ReposTest do
  use Githubstars.DataCase

  alias Githubstars.Repos

  describe "repositories" do
    alias Githubstars.Repos.Repository

    @valid_attrs %{
      description: "some description",
      github_id: "some github_id",
      language: "some language",
      name: "some name",
      url: "some url"
    }
    @update_attrs %{
      description: "some updated description",
      github_id: "some updated github_id",
      language: "some updated language",
      name: "some updated name",
      url: "some updated url"
    }
    @invalid_attrs %{description: nil, github_id: nil, language: nil, name: nil, url: nil}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Repos.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Repos.list_repositories() == [repository]
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Repos.create_repository(@valid_attrs)
      assert repository.description == "some description"
      assert repository.github_id == "some github_id"
      assert repository.language == "some language"
      assert repository.name == "some name"
      assert repository.url == "some url"
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repos.create_repository(@invalid_attrs)
    end
  end

  describe "tag_groups" do
    alias Githubstars.Repos.TagGroup

    @valid_attrs %{tags: []}
    @update_attrs %{tags: []}
    @invalid_attrs %{tags: nil}

    def tag_group_fixture(attrs \\ %{}) do
      {:ok, tag_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Repos.create_tag_group()

      tag_group
    end

    test "get_tag_group!/1 returns the tag_group with given id" do
      tag_group = tag_group_fixture()
      assert Repos.get_tag_group!(tag_group.id) == tag_group
    end

    test "create_tag_group/1 with valid data creates a tag_group" do
      assert {:ok, %TagGroup{} = tag_group} = Repos.create_tag_group(@valid_attrs)
      assert tag_group.tags == []
    end

    test "create_tag_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repos.create_tag_group(@invalid_attrs)
    end

    test "update_tag_group/2 with valid data updates the tag_group" do
      tag_group = tag_group_fixture()
      assert {:ok, tag_group} = Repos.update_tag_group(tag_group, @update_attrs)
      assert %TagGroup{} = tag_group
      assert tag_group.tags == []
    end

    test "update_tag_group/2 with invalid data returns error changeset" do
      tag_group = tag_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Repos.update_tag_group(tag_group, @invalid_attrs)
      assert tag_group == Repos.get_tag_group!(tag_group.id)
    end
  end
end
