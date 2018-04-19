defmodule Githubstars.Users.CreateTest do
  use Githubstars.DataCase

  alias Githubstars.Users.Create
  alias Githubstars.Users.User

  describe "call/1" do
    test "should create an user" do
      params = %{"name" => "thiamsantos"}

      {:ok, user} = Create.call(params)
      assert user.name == params["name"]

      persisted_user = Repo.get!(User, user.id)
      assert persisted_user == user
    end

    test "name is required" do
      params = %{"name" => nil}

      actual = Create.call(params)

      expected =
        {:error,
         {:validation, [%{"field" => "name", "message" => "can't be blank", "type" => :required}]}}

      assert actual == expected
    end

    test "should return not found" do
      params = %{"name" => "somecreepyname"}

      actual = Create.call(params)
      expected = {:error, {:not_found, %{"message" => "username not found"}}}

      assert actual == expected
    end
  end
end
