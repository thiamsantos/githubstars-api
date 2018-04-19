defmodule GithubstarsWeb.RepositoryControllerTest do
  use GithubstarsWeb.ConnCase

  alias Githubstars.Stars
  alias Githubstars.Stars.Repository

  @create_attrs %{description: "some description", github_id: "some github_id", language: "some language", name: "some name", url: "some url"}
  @update_attrs %{description: "some updated description", github_id: "some updated github_id", language: "some updated language", name: "some updated name", url: "some updated url"}
  @invalid_attrs %{description: nil, github_id: nil, language: nil, name: nil, url: nil}

  def fixture(:repository) do
    {:ok, repository} = Stars.create_repository(@create_attrs)
    repository
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all repositories", %{conn: conn} do
      conn = get conn, repository_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create repository" do
    test "renders repository when data is valid", %{conn: conn} do
      conn = post conn, repository_path(conn, :create), repository: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, repository_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "github_id" => "some github_id",
        "language" => "some language",
        "name" => "some name",
        "url" => "some url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, repository_path(conn, :create), repository: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update repository" do
    setup [:create_repository]

    test "renders repository when data is valid", %{conn: conn, repository: %Repository{id: id} = repository} do
      conn = put conn, repository_path(conn, :update, repository), repository: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, repository_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "github_id" => "some updated github_id",
        "language" => "some updated language",
        "name" => "some updated name",
        "url" => "some updated url"}
    end

    test "renders errors when data is invalid", %{conn: conn, repository: repository} do
      conn = put conn, repository_path(conn, :update, repository), repository: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete repository" do
    setup [:create_repository]

    test "deletes chosen repository", %{conn: conn, repository: repository} do
      conn = delete conn, repository_path(conn, :delete, repository)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, repository_path(conn, :show, repository)
      end
    end
  end

  defp create_repository(_) do
    repository = fixture(:repository)
    {:ok, repository: repository}
  end
end
