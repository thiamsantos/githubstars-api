defmodule GithubstarsWeb.TagControllerTest do
  use GithubstarsWeb.ConnCase

  alias Githubstars.Users
  alias Githubstars.Repos.Loader, as: ReposLoader

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "tags" do
    test "list tags", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      conn = get conn, user_repository_tag_path(conn, :index, user.id, repository_id)
      actual = json_response(conn, 200)["data"]

      assert actual == []
    end

    test "invalid user", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      conn = get conn, user_repository_tag_path(conn, :index, user.id + 100, repository_id)
      actual = json_response(conn, 404)

      expected = %{
        "code" => 200,
        "errors" => [%{"code" => 200, "message" => "tags not found"}],
        "message" => "Not found!"
      }

      assert actual == expected
    end

    test "invalid repository", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      conn = get conn, user_repository_tag_path(conn, :index, user.id + 100, repository_id + 100)
      actual = json_response(conn, 404)

      expected = %{
        "code" => 200,
        "errors" => [%{"code" => 200, "message" => "tags not found"}],
        "message" => "Not found!"
      }

      assert actual == expected
    end

    test "update tags", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{
        "tags" => ["react", "js"]
      }

      path = user_repository_tag_path(conn, :index, user.id, repository_id, params)
      conn = put conn, path
      update_response = json_response(conn, 200)["data"]

      assert update_response == ["js", "react"]

      conn = get conn, user_repository_tag_path(conn, :index, user.id, repository_id)
      list_response = json_response(conn, 200)["data"]

      assert list_response == ["js", "react"]
    end

    test "missing tags", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{}

      path = user_repository_tag_path(conn, :index, user.id, repository_id, params)
      conn = put conn, path
      actual = json_response(conn, 422)

      expected = %{
        "code" => 100,
        "errors" => [
          %{
            "code" => 101,
            "field" => "tags",
            "message" => "can't be blank"
          }
        ],
        "message" => "Validation failed!"
      }

      assert actual == expected
    end

    test "invalid tags", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})
      {:ok, repository_id} = ReposLoader.get_repo_id_by_github_id(61_527_215)

      params = %{"tags" => [%{something: "else"}, %{cool: "map"}]}

      path = user_repository_tag_path(conn, :index, user.id, repository_id, params)
      conn = put conn, path
      actual = json_response(conn, 422)

      expected = %{
        "code" => 100,
        "errors" => [
          %{"code" => 102, "field" => "tags", "message" => "is invalid"}
        ],
        "message" => "Validation failed!"
      }

      assert actual == expected
    end
  end
end
