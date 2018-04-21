defmodule Githubstars.UsersTest do
  use Githubstars.DataCase

  alias Githubstars.Users.{Create, User}
  alias Githubstars.Repos.Repository
  alias Githubstars.Tags.TagGroup
  alias Githubstars.Repos.Loader, as: ReposLoader
  alias Githubstars.Repos.Mutator, as: ReposMutator

  @github_client Application.get_env(:githubstars, :github_client)
  @valid_params %{"name" => "thiamsantos"}

  describe "users" do
    test "should create an user" do
      {:ok, user} = Create.call(@valid_params)
      assert user.name == @valid_params["name"]

      persisted_user = Repo.get!(User, user.id)
      assert persisted_user == user
    end

    test "name is required" do
      params = %{"name" => nil}

      actual = Create.call(params)

      expected =
        {:error,
         {:validation, [%{"field" => "name", "message" => "can't be blank", "type" => :required}]}}

      assert actual == expected
    end

    test "should return not found" do
      params = %{"name" => "somecreepyname"}

      actual = Create.call(params)
      expected = {:error, {:not_found, [%{"message" => "username not found"}]}}

      assert actual == expected
    end

    test "should create the starred repos by the user" do
      {:ok, _user} = Create.call(@valid_params)

      {:ok, %HTTPoison.Response{body: first_page}} =
        @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: second_page}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: third_page}} =
        @github_client.get("/user/13632762/starred?page=3")

      body =
        [first_page, second_page, third_page]
        |> Enum.map(&Jason.decode!/1)
        |> Enum.concat()

      expected =
        body
        |> Enum.map(fn repo -> repo["id"] end)

      actual =
        Repository
        |> Repo.all()
        |> Enum.map(fn repo -> repo.github_id end)

      assert actual == expected
    end

    test "should initiate empty for each repo starred by the user" do
      {:ok, user} = Create.call(@valid_params)

      {:ok, %HTTPoison.Response{body: first_page}} =
        @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: second_page}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: third_page}} =
        @github_client.get("/user/13632762/starred?page=3")

      body =
        [first_page, second_page, third_page]
        |> Enum.map(&Jason.decode!/1)
        |> Enum.concat()

      expected =
        body
        |> Enum.map(fn repo ->
          {:ok, id} = ReposLoader.get_repo_id_by_github_id(repo["id"])
          id
        end)
        |> Enum.map(fn repo_id -> {user.id, repo_id, []} end)

      actual =
        TagGroup
        |> Repo.all()
        |> Enum.map(fn tag_group ->
          {tag_group.user_id, tag_group.repository_id, tag_group.tags}
        end)

      assert actual == expected
    end

    test "should not create duplicates repos" do
      {:ok, %HTTPoison.Response{body: first_page}} =
        @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: second_page}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: third_page}} =
        @github_client.get("/user/13632762/starred?page=3")

      body =
        [first_page, second_page, third_page]
        |> Enum.map(&Jason.decode!/1)
        |> Enum.concat()

      expected =
        body
        |> Enum.map(fn repo ->
          %{
            description: repo["description"],
            github_id: repo["id"],
            language: repo["language"],
            name: repo["name"],
            url: repo["html_url"]
          }
        end)
        |> Enum.map(fn repo ->
          {:ok, persisted_repo} = ReposMutator.create(repo)
          persisted_repo
        end)

      {:ok, _user} = Create.call(@valid_params)

      actual = Repo.all(Repository)

      assert actual == expected
    end
  end
end
