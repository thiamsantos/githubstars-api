defmodule Githubstars.Repos.ListTest do
  use Githubstars.DataCase

  alias Githubstars.Users
  alias Githubstars.Repos.List

  @github_client Application.get_env(:githubstars, :github_client)

  describe "list repositories" do
    test "should return all repositories starred by the user" do
      {:ok, user} = Users.create(%{"name" => "thiamsantos"})

      {:ok, %HTTPoison.Response{body: body1}} = @github_client.get("/users/thiamsantos/starred")

      {:ok, %HTTPoison.Response{body: body2}} =
        @github_client.get("/user/13632762/starred?page=2")

      {:ok, %HTTPoison.Response{body: body3}} =
        @github_client.get("/user/13632762/starred?page=3")

      expected = Jason.decode!(body1) ++ Jason.decode!(body2) ++ Jason.decode!(body3)

      {:ok, actual} = List.call(%{"user_id" => user.id})

      assert length(actual) == length(expected)
    end
  end
end
