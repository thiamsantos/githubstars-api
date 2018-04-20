defmodule Githubstars.Repos.ListTest do
  use Githubstars.DataCase

  alias Githubstars.Users
  alias Githubstars.Repos.List

  @github_client Application.get_env(:githubstars, :github_client)

  describe "list repositories" do
    test "should return all repositories starred by the user" do
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

      {:ok, actual} = List.call(%{"user_id" => user.id})

      assert length(actual) == length(expected)
    end
  end
end
