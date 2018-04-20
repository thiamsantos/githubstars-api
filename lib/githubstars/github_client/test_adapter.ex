defmodule Githubstars.GithubClient.TestAdapter do
  @moduledoc """
  Github client mock.
  """
  @behaviour Githubstars.GithubClient

  def get("/users/thiamsantos/starred") do
    body =
      [
        %{
          "id" => 61_527_215,
          "name" => "react-in-patterns",
          "full_name" => "krasimir/react-in-patterns",
          "owner" => %{
            "login" => "krasimir",
            "id" => 528_677,
            "avatar_url" => "https://avatars2.githubusercontent.com/u/528677?v=4",
            "gravatar_id" => "",
            "url" => "https://api.github.com/users/krasimir",
            "html_url" => "https://github.com/krasimir",
            "followers_url" => "https://api.github.com/users/krasimir/followers",
            "following_url" => "https://api.github.com/users/krasimir/following{/other_user}",
            "gists_url" => "https://api.github.com/users/krasimir/gists{/gist_id}",
            "starred_url" => "https://api.github.com/users/krasimir/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/krasimir/subscriptions",
            "organizations_url" => "https://api.github.com/users/krasimir/orgs",
            "repos_url" => "https://api.github.com/users/krasimir/repos",
            "events_url" => "https://api.github.com/users/krasimir/events{/privacy}",
            "received_events_url" => "https://api.github.com/users/krasimir/received_events",
            "type" => "User",
            "site_admin" => false
          },
          "private" => false,
          "html_url" => "https://github.com/krasimir/react-in-patterns",
          "description" =>
            "A free book that talks about design patterns/techniques used while developing with React.",
          "fork" => false,
          "url" => "https://api.github.com/repos/krasimir/react-in-patterns",
          "forks_url" => "https://api.github.com/repos/krasimir/react-in-patterns/forks",
          "keys_url" => "https://api.github.com/repos/krasimir/react-in-patterns/keys{/key_id}",
          "collaborators_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/collaborators{/collaborator}",
          "teams_url" => "https://api.github.com/repos/krasimir/react-in-patterns/teams",
          "hooks_url" => "https://api.github.com/repos/krasimir/react-in-patterns/hooks",
          "issue_events_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/issues/events{/number}",
          "events_url" => "https://api.github.com/repos/krasimir/react-in-patterns/events",
          "assignees_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/assignees{/user}",
          "branches_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/branches{/branch}",
          "tags_url" => "https://api.github.com/repos/krasimir/react-in-patterns/tags",
          "blobs_url" => "https://api.github.com/repos/krasimir/react-in-patterns/git/blobs{/sha}",
          "git_tags_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/git/tags{/sha}",
          "git_refs_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/git/refs{/sha}",
          "trees_url" => "https://api.github.com/repos/krasimir/react-in-patterns/git/trees{/sha}",
          "statuses_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/statuses/{sha}",
          "languages_url" => "https://api.github.com/repos/krasimir/react-in-patterns/languages",
          "stargazers_url" => "https://api.github.com/repos/krasimir/react-in-patterns/stargazers",
          "contributors_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/contributors",
          "subscribers_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/subscribers",
          "subscription_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/subscription",
          "commits_url" => "https://api.github.com/repos/krasimir/react-in-patterns/commits{/sha}",
          "git_commits_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/git/commits{/sha}",
          "comments_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/comments{/number}",
          "issue_comment_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/issues/comments{/number}",
          "contents_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/contents/{+path}",
          "compare_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/compare/{base}...{head}",
          "merges_url" => "https://api.github.com/repos/krasimir/react-in-patterns/merges",
          "archive_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/{archive_format}{/ref}",
          "downloads_url" => "https://api.github.com/repos/krasimir/react-in-patterns/downloads",
          "issues_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/issues{/number}",
          "pulls_url" => "https://api.github.com/repos/krasimir/react-in-patterns/pulls{/number}",
          "milestones_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/milestones{/number}",
          "notifications_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/notifications{?since,all,participating}",
          "labels_url" => "https://api.github.com/repos/krasimir/react-in-patterns/labels{/name}",
          "releases_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/releases{/id}",
          "deployments_url" =>
            "https://api.github.com/repos/krasimir/react-in-patterns/deployments",
          "created_at" => "2016-06-20T07:53:11Z",
          "updated_at" => "2018-04-20T13:04:36Z",
          "pushed_at" => "2018-04-20T04:27:39Z",
          "git_url" => "git://github.com/krasimir/react-in-patterns.git",
          "ssh_url" => "git@github.com:krasimir/react-in-patterns.git",
          "clone_url" => "https://github.com/krasimir/react-in-patterns.git",
          "svn_url" => "https://github.com/krasimir/react-in-patterns",
          "homepage" => "https://www.gitbook.com/book/krasimir/react-in-patterns/",
          "size" => 128_716,
          "stargazers_count" => 5549,
          "watchers_count" => 5549,
          "language" => "JavaScript",
          "has_issues" => true,
          "has_projects" => true,
          "has_downloads" => true,
          "has_wiki" => true,
          "has_pages" => false,
          "forks_count" => 302,
          "mirror_url" => nil,
          "archived" => false,
          "open_issues_count" => 2,
          "license" => %{
            "key" => "mit",
            "name" => "MIT License",
            "spdx_id" => "MIT",
            "url" => "https://api.github.com/licenses/mit"
          },
          "forks" => 302,
          "open_issues" => 2,
          "watchers" => 5549,
          "default_branch" => "master"
        },
        %{
          "id" => 130_138_377,
          "name" => "permit",
          "full_name" => "ianstormtaylor/permit",
          "owner" => %{
            "login" => "ianstormtaylor",
            "id" => 311_752,
            "avatar_url" => "https://avatars0.githubusercontent.com/u/311752?v=4",
            "gravatar_id" => "",
            "url" => "https://api.github.com/users/ianstormtaylor",
            "html_url" => "https://github.com/ianstormtaylor",
            "followers_url" => "https://api.github.com/users/ianstormtaylor/followers",
            "following_url" =>
              "https://api.github.com/users/ianstormtaylor/following{/other_user}",
            "gists_url" => "https://api.github.com/users/ianstormtaylor/gists{/gist_id}",
            "starred_url" => "https://api.github.com/users/ianstormtaylor/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/ianstormtaylor/subscriptions",
            "organizations_url" => "https://api.github.com/users/ianstormtaylor/orgs",
            "repos_url" => "https://api.github.com/users/ianstormtaylor/repos",
            "events_url" => "https://api.github.com/users/ianstormtaylor/events{/privacy}",
            "received_events_url" => "https://api.github.com/users/ianstormtaylor/received_events",
            "type" => "User",
            "site_admin" => false
          },
          "private" => false,
          "html_url" => "https://github.com/ianstormtaylor/permit",
          "description" => "An unopinionated authentication library for building Node.js APIs.",
          "fork" => false,
          "url" => "https://api.github.com/repos/ianstormtaylor/permit",
          "forks_url" => "https://api.github.com/repos/ianstormtaylor/permit/forks",
          "keys_url" => "https://api.github.com/repos/ianstormtaylor/permit/keys{/key_id}",
          "collaborators_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/collaborators{/collaborator}",
          "teams_url" => "https://api.github.com/repos/ianstormtaylor/permit/teams",
          "hooks_url" => "https://api.github.com/repos/ianstormtaylor/permit/hooks",
          "issue_events_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/issues/events{/number}",
          "events_url" => "https://api.github.com/repos/ianstormtaylor/permit/events",
          "assignees_url" => "https://api.github.com/repos/ianstormtaylor/permit/assignees{/user}",
          "branches_url" => "https://api.github.com/repos/ianstormtaylor/permit/branches{/branch}",
          "tags_url" => "https://api.github.com/repos/ianstormtaylor/permit/tags",
          "blobs_url" => "https://api.github.com/repos/ianstormtaylor/permit/git/blobs{/sha}",
          "git_tags_url" => "https://api.github.com/repos/ianstormtaylor/permit/git/tags{/sha}",
          "git_refs_url" => "https://api.github.com/repos/ianstormtaylor/permit/git/refs{/sha}",
          "trees_url" => "https://api.github.com/repos/ianstormtaylor/permit/git/trees{/sha}",
          "statuses_url" => "https://api.github.com/repos/ianstormtaylor/permit/statuses/{sha}",
          "languages_url" => "https://api.github.com/repos/ianstormtaylor/permit/languages",
          "stargazers_url" => "https://api.github.com/repos/ianstormtaylor/permit/stargazers",
          "contributors_url" => "https://api.github.com/repos/ianstormtaylor/permit/contributors",
          "subscribers_url" => "https://api.github.com/repos/ianstormtaylor/permit/subscribers",
          "subscription_url" => "https://api.github.com/repos/ianstormtaylor/permit/subscription",
          "commits_url" => "https://api.github.com/repos/ianstormtaylor/permit/commits{/sha}",
          "git_commits_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/git/commits{/sha}",
          "comments_url" => "https://api.github.com/repos/ianstormtaylor/permit/comments{/number}",
          "issue_comment_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/issues/comments{/number}",
          "contents_url" => "https://api.github.com/repos/ianstormtaylor/permit/contents/{+path}",
          "compare_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/compare/{base}...{head}",
          "merges_url" => "https://api.github.com/repos/ianstormtaylor/permit/merges",
          "archive_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/{archive_format}{/ref}",
          "downloads_url" => "https://api.github.com/repos/ianstormtaylor/permit/downloads",
          "issues_url" => "https://api.github.com/repos/ianstormtaylor/permit/issues{/number}",
          "pulls_url" => "https://api.github.com/repos/ianstormtaylor/permit/pulls{/number}",
          "milestones_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/milestones{/number}",
          "notifications_url" =>
            "https://api.github.com/repos/ianstormtaylor/permit/notifications{?since,all,participating}",
          "labels_url" => "https://api.github.com/repos/ianstormtaylor/permit/labels{/name}",
          "releases_url" => "https://api.github.com/repos/ianstormtaylor/permit/releases{/id}",
          "deployments_url" => "https://api.github.com/repos/ianstormtaylor/permit/deployments",
          "created_at" => "2018-04-19T00:43:11Z",
          "updated_at" => "2018-04-20T13:04:33Z",
          "pushed_at" => "2018-04-19T16:23:31Z",
          "git_url" => "git://github.com/ianstormtaylor/permit.git",
          "ssh_url" => "git@github.com:ianstormtaylor/permit.git",
          "clone_url" => "https://github.com/ianstormtaylor/permit.git",
          "svn_url" => "https://github.com/ianstormtaylor/permit",
          "homepage" => "",
          "size" => 493,
          "stargazers_count" => 118,
          "watchers_count" => 118,
          "language" => "JavaScript",
          "has_issues" => true,
          "has_projects" => true,
          "has_downloads" => true,
          "has_wiki" => true,
          "has_pages" => false,
          "forks_count" => 0,
          "mirror_url" => nil,
          "archived" => false,
          "open_issues_count" => 2,
          "license" => %{
            "key" => "mit",
            "name" => "MIT License",
            "spdx_id" => "MIT",
            "url" => "https://api.github.com/licenses/mit"
          },
          "forks" => 0,
          "open_issues" => 2,
          "watchers" => 118,
          "default_branch" => "master"
        }
      ]
      |> Jason.encode!()

    {:ok, %HTTPoison.Response{body: body, status_code: 200}}
  end

  def get("/users/somecreepyname/starred") do
    body =
      %{
        "message" => "Not Found",
        "documentation_url" =>
          "https://developer.github.com/v3/activity/starring/#list-repositories-being-starred"
      }
      |> Jason.encode!()

    {:ok, %HTTPoison.Response{body: body, status_code: 404}}
  end
end
