defmodule GithubstarsWeb.UserControllerTest do
  use GithubstarsWeb.ConnCase

  @create_attrs %{name: "thiamsantos"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), @create_attrs
      assert %{"id" => _id, "name" => name} = json_response(conn, 201)["data"]

      assert name == @create_attrs[:name]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), %{name: nil}

      actual = json_response(conn, 422)

      expected = %{
        "code" => 100,
        "message" => "Validation failed!",
        "errors" => [%{"code" => 101, "field" => "name", "message" => "can't be blank"}]
      }

      assert actual === expected
    end

    test "return 404 when username not found", %{conn: conn} do
      conn = post conn, user_path(conn, :create), %{name: "somecreepyname"}

      actual = json_response(conn, 404)

      expected = %{
        "code" => 200,
        "errors" => [%{"code" => 200, "message" => "username not found"}],
        "message" => "Not found!"
      }

      assert actual === expected
    end
  end
end
