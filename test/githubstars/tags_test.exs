defmodule Githubstars.TagsTest do
  use Githubstars.DataCase

  alias Githubstars.Repos.Loader, as: ReposLoader
  alias Githubstars.Tags
  alias Githubstars.Users

  describe "tags" do
    test "all tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}
      actual = Tags.all(params)
      expected = {:ok, []}

      assert actual == expected
    end

    test "invalid repository" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{"repository_id" => "#{repository_id + 100}", "user_id" => "#{user.id}"}
      actual = Tags.all(params)
      expected = {:error, {:not_found, [%{"message" => "tags not found"}]}}

      assert actual == expected
    end

    test "invalid user" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id + 1}"}
      actual = Tags.all(params)
      expected = {:error, {:not_found, [%{"message" => "tags not found"}]}}

      assert actual == expected
    end

    test "update tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      all_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}

      update_params =
        all_params
        |> Map.put("tags", ["react", "js"])

      {:ok, _tags} = Tags.update(update_params)

      actual = Tags.all(all_params)
      expected = {:ok, ["js", "react"]}

      assert actual == expected
    end

    test "missing tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      all_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}

      update_params =
        all_params
        |> Map.put("tags", nil)

      actual = Tags.update(update_params)

      expected =
        {:error,
         {:validation, [%{"field" => "tags", "message" => "can't be blank", "type" => :required}]}}

      assert actual == expected
    end

    test "invalid tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      all_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}

      update_params =
        all_params
        |> Map.put("tags", [%{something: "else"}, %{cool: "map"}])

      actual = Tags.update(update_params)

      expected =
        {:error,
         {:validation, [%{"field" => "tags", "message" => "is invalid", "type" => :cast}]}}

      assert actual == expected
    end

    test "the tags should be lowercased, trimmed and unique" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      all_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}

      update_params =
        all_params
        |> Map.put("tags", ["react", "js", "js", "react", "ELIXIR", "  tag  "])

      {:ok, _tags} = Tags.update(update_params)

      actual = Tags.all(all_params)
      expected = {:ok, ["elixir", "js", "react", "tag"]}

      assert actual == expected
    end
  end
end
