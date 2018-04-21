defmodule Githubstars.ReposTest do
  use Githubstars.DataCase

  alias Githubstars.{Users, Repos, Tags}
  alias Githubstars.Repos.Loader

  @github_client Application.get_env(:githubstars, :github_client)

  describe "repositories" do
    test "should return all repositories starred by the user" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})

      {:ok, %HTTPoison.Response{body: first_page}} =
        @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: second_page}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: third_page}} =
        @github_client.get("/user/13632762/starred?page=3")

      expected_entries =
        [first_page, second_page, third_page]
        |> Enum.map(&Jason.decode!/1)
        |> Enum.concat()

      {:ok, response} = Repos.all(%{"user_id" => "#{user.id}"})

      assert length(response.entries) == length(expected_entries)

      assert response.page_size == 30
      assert response.page_number == 1
      assert response.total_pages == 1
      assert response.total_entries == length(expected_entries)
    end

    test "should filter repositories by tag" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = Loader.get_repo_id_by_github_id(61_527_215)

      update_tags_params = %{
        "repository_id" => "#{repository_id}",
        "user_id" => "#{user.id}",
        "tags" => ["react", "js"]
      }

      {:ok, _tags} = Tags.update(update_tags_params)

      {:ok, response} = Repos.all(%{"user_id" => "#{user.id}", "tag" => "react"})

      expected = %{
        "github_id" => 61_527_215,
        "name" => "react-in-patterns",
        "url" => "https://github.com/krasimir/react-in-patterns",
        "description" =>
          "A free book that talks about design patterns/techniques used while developing with React.",
        "language" => "JavaScript"
      }

      assert length(response.entries) == 1

      item = List.first(response.entries)
      assert item.github_id == expected["github_id"]
      assert item.name == expected["name"]
      assert item.url == expected["url"]
      assert item.description == expected["description"]
      assert item.language == expected["language"]

      assert response.page_size == 30
      assert response.page_number == 1
      assert response.total_pages == 1
      assert response.total_entries == 1
    end

    test "should support pagination" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})

      {:ok, response} = Repos.all(%{"user_id" => "#{user.id}", "page_size" => 2, "page" => 2})

      assert response.page_size == 2
      assert response.page_number == 2
      assert response.total_pages == 3
      assert response.total_entries == 6
    end
  end
end
