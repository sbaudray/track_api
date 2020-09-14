defmodule Track.Issues do
  alias Track.Repo
  alias Track.Issues.Issue

  def get_issue(id) do
    Repo.get(Issue, id)
    |> Repo.preload(:author)
  end

  def list_issues() do
    Repo.all(Issue)
    |> Repo.preload(:author)
  end

  def create_issue(attrs \\ %{}) do
    {:ok, issue} =
      %Issue{}
      |> Issue.changeset(attrs)
      |> Repo.insert()

    {:ok, Repo.preload(issue, :author)}
  end

  def mark_issue_as(id, status) do
    Repo.get(Issue, id)
    |> Repo.preload(:author)
    |> Issue.changeset(%{status: status})
    |> Repo.update()
  end
end
