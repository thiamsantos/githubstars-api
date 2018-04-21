defmodule Githubstars.ReposTest do
  use Githubstars.DataCase

  alias Githubstars.Users
  alias Githubstars.Repos
  alias Githubstars.Repos.Loader
  alias Githubstars.Tags.Update, as: TagsUpdate

  @github_client Application.get_env(:githubstars, :github_client)

  describe "repositories" do
    test "list should return all repositories starred by the user" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})

      {:ok, %HTTPoison.Response{body: first_page}} =
        @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: second_page}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: third_page}} =
        @github_client.get("/user/13632762/starred?page=3")

      expected =
        [first_page, second_page, third_page]
        |> Enum.map(&Jason.decode!/1)
        |> Enum.concat()

      {:ok, actual} = Repos.list(%{"user_id" => "#{user.id}", "tag" => ""})

      assert length(actual) == length(expected)
    end

    test "should filter repositories by tag" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = Loader.get_repo_id_by_github_id(61_527_215)

      update_tags_params = %{"repository_id" => "#{repository_id}", "user_id" => "#{user.id}", "tags" => ["react", "js"]}

      {:ok, _tags} = TagsUpdate.call(update_tags_params)

      {:ok, actual} = Repos.list(%{"user_id" => "#{user.id}", "tag" => "react"})
      expected = %{
        "github_id" => 61_527_215,
        "name" => "react-in-patterns",
        "url" => "https://github.com/krasimir/react-in-patterns",
        "description" =>
          "A free book that talks about design patterns/techniques used while developing with React.",
        "language" => "JavaScript"
      }

      assert length(actual) == 1

      item = List.first(actual)
      assert item.github_id == expected["github_id"]
      assert item.name == expected["name"]
      assert item.url == expected["url"]
      assert item.description == expected["description"]
      assert item.language == expected["language"]
    end
  end
end
