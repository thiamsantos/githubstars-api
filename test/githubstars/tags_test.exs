defmodule Githubstars.TagsTest do
  use Githubstars.DataCase

  alias Githubstars.Repos.Loader, as: ReposLoader
  alias Githubstars.Tags.Update
  alias Githubstars.Tags.List
  alias Githubstars.Users

  describe "tags" do
    test "list tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}
      actual = List.call(params)
      expected = {:ok, []}

      assert actual == expected
    end

    test "update tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      list_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}

      update_params =
        list_params
        |> Map.put("tags", ["react", "js"])

      {:ok, _tags} = Update.call(update_params)

      actual = List.call(list_params)
      expected = {:ok, ["react", "js"]}

      assert actual == expected
    end
  end
end
