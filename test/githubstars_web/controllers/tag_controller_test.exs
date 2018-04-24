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
  end
end
