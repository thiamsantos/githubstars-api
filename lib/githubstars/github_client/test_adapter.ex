defmodule Githubstars.GithubClient.TestAdapter do
  @moduledoc """
  Github client mock.
  """
  @behaviour Githubstars.GithubClient

  def head("/users/thiamsantos") do
    {:ok, %HTTPoison.Response{status_code: 200}}
  end

  def head("/users/somecreepyname") do
    {:ok, %HTTPoison.Response{status_code: 404}}
  end

  def get("/users/thiamsantos/starred") do
    body =
      [
        %{
          "id" => 61_527_215,
          "name" => "react-in-patterns",
          "html_url" => "https://github.com/krasimir/react-in-patterns",
          "description" =>
            "A free book that talks about design patterns/techniques used while developing with React.",
          "language" => "JavaScript"
        },
        %{
          "id" => 130_138_377,
          "name" => "permit",
          "html_url" => "https://github.com/ianstormtaylor/permit",
          "description" => "An unopinionated authentication library for building Node.js APIs.",
          "language" => "JavaScript"
        }
      ]
      |> Jason.encode!()

    links =
      ~s(<https://api.github.com/user/13632762/starred?page=2>; rel="next", ) <>
        ~s(<https://api.github.com/user/13632762/starred?page=3>; rel="last")

    headers = [
      {"Link", links}
    ]

    {:ok, %HTTPoison.Response{body: body, status_code: 200, headers: headers}}
  end

  def get("/user/13632762/starred?page=2") do
    body =
      [
        %{
          "id" => 27_307_575,
          "name" => "enacl",
          "html_url" => "https://github.com/jlouis/enacl",
          "description" => "Erlang bindings for NaCl / libsodium",
          "language" => "Erlang"
        },
        %{
          "id" => 68_748_701,
          "name" => "react-password-mask",
          "html_url" => "https://github.com/zakangelle/react-password-mask",
          "description" => "Show/hide the contents of a password field.",
          "language" => "JavaScript"
        }
      ]
      |> Jason.encode!()

    links =
      ~s(<https://api.github.com/user/13632762/starred?page=1>; rel="prev", ) <>
        ~s(<https://api.github.com/user/13632762/starred?page=3>; rel="next", ) <>
        ~s(<https://api.github.com/user/13632762/starred?page=3>; rel="last", ) <>
        ~s(<https://api.github.com/user/13632762/starred?page=1>; rel="first")

    headers = [
      {"Link", links}
    ]

    {:ok, %HTTPoison.Response{body: body, status_code: 200, headers: headers}}
  end

  def get("/user/13632762/starred?page=3") do
    body =
      [
        %{
          "id" => 44_207_164,
          "name" => "toth",
          "html_url" => "https://github.com/filipelinhares/toth",
          "description" => ":zap: Styleguide generator that just work.",
          "language" => "JavaScript"
        },
        %{
          "id" => 24_217_086,
          "name" => "awesome-svg",
          "html_url" => "https://github.com/willianjusten/awesome-svg",
          "description" => "A curated list of SVG.",
          "language" => "Ruby"
        }
      ]
      |> Jason.encode!()

    links =
      ~s(<https://api.github.com/user/13632762/starred?page=2>; rel="prev", ) <>
        ~s(<https://api.github.com/user/13632762/starred?page=1>; rel="first")

    headers = [
      {"Link", links}
    ]

    {:ok, %HTTPoison.Response{body: body, status_code: 200, headers: headers}}
  end
end
