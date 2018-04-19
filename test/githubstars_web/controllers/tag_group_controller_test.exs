defmodule GithubstarsWeb.TagGroupControllerTest do
  use GithubstarsWeb.ConnCase

  alias Githubstars.Stars
  alias Githubstars.Stars.TagGroup

  @create_attrs %{tags: []}
  @update_attrs %{tags: []}
  @invalid_attrs %{tags: nil}

  def fixture(:tag_group) do
    {:ok, tag_group} = Stars.create_tag_group(@create_attrs)
    tag_group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tag_groups", %{conn: conn} do
      conn = get conn, tag_group_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tag_group" do
    test "renders tag_group when data is valid", %{conn: conn} do
      conn = post conn, tag_group_path(conn, :create), tag_group: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, tag_group_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "tags" => []}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, tag_group_path(conn, :create), tag_group: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tag_group" do
    setup [:create_tag_group]

    test "renders tag_group when data is valid", %{conn: conn, tag_group: %TagGroup{id: id} = tag_group} do
      conn = put conn, tag_group_path(conn, :update, tag_group), tag_group: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, tag_group_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "tags" => []}
    end

    test "renders errors when data is invalid", %{conn: conn, tag_group: tag_group} do
      conn = put conn, tag_group_path(conn, :update, tag_group), tag_group: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tag_group" do
    setup [:create_tag_group]

    test "deletes chosen tag_group", %{conn: conn, tag_group: tag_group} do
      conn = delete conn, tag_group_path(conn, :delete, tag_group)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, tag_group_path(conn, :show, tag_group)
      end
    end
  end

  defp create_tag_group(_) do
    tag_group = fixture(:tag_group)
    {:ok, tag_group: tag_group}
  end
end
