defmodule GithubstarsWeb.RepositoryControllerTest do
  use GithubstarsWeb.ConnCase

  alias Githubstars.Users

  @github_client Application.get_env(:githubstars, :github_client)

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})

      {:ok, %HTTPoison.Response{body: body1}} = @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: body2}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: body3}} =
        @github_client.get("/user/13632762/starred?page=3")

      expected = Jason.decode!(body1) ++ Jason.decode!(body2) ++ Jason.decode!(body3)

      conn = get conn, user_repository_path(conn, :index, user.id)
      actual = json_response(conn, 200)

      assert length(actual) == length(expected)
    end
  end

end
