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

    test "update tags" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      all_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}"}

      update_params =
        all_params
        |> Map.put("tags", ["react", "js"])

      {:ok, _tags} = Tags.update(update_params)

      actual = Tags.all(all_params)
      expected = {:ok, ["react", "js"]}

      assert actual == expected
    end
  end
end
