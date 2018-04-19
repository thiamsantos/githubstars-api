# defmodule GithubstarsWeb.RepositoryControllerTest do
#   use GithubstarsWeb.ConnCase

#   setup %{conn: conn} do
#     {:ok, conn: put_req_header(conn, "accept", "application/json")}
#   end

#   describe "index" do
#     test "lists all repositories", %{conn: conn} do
#       conn = get conn, repository_path(conn, :index)
#       assert json_response(conn, 200)["data"] == []
#     end
#   end
# end
