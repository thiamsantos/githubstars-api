defmodule GithubstarsWeb.RepositoryControllerTest do
  use GithubstarsWeb.ConnCase

  alias Githubstars.{Users, Tags}
  alias Githubstars.Repos.Loader

  @github_client Application.get_env(:githubstars, :github_client)

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "repositories" do
    test "return all repos associated with an user", %{conn: conn} do
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

      conn = get conn, user_repository_path(conn, :index, user.id)
      actual = json_response(conn, 200)

      assert length(actual) == length(expected)
    end

    test "filter repos by tag", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = Loader.get_repo_id_by_github_id(61_527_215)

      update_tags_params = %{
        "repository_id" => "#{repository_id}",
        "user_id" => "#{user.id}",
        "tags" => ["react", "js"]
      }

      {:ok, _tags} = Tags.update(update_tags_params)

      expected = %{
        "github_id" => 61_527_215,
        "name" => "react-in-patterns",
        "url" => "https://github.com/krasimir/react-in-patterns",
        "description" =>
          "A free book that talks about design patterns/techniques used while developing with React.",
        "language" => "JavaScript"
      }

      conn = get conn, user_repository_path(conn, :index, user.id, tag: "react")
      actual = json_response(conn, 200)

      assert length(actual) == 1

      item = List.first(actual)
      assert item["github_id"] == expected["github_id"]
      assert item["name"] == expected["name"]
      assert item["url"] == expected["url"]
      assert item["description"] == expected["description"]
      assert item["language"] == expected["language"]
    end
  end
end
