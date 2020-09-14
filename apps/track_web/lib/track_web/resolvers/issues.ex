defmodule TrackWeb.Resolvers.Issues do
  alias Track.Issues
  alias Track.Issues.Issue

  def find(%{id: id}) do
    {:ok, Track.Issues.get_issue(id)}
  end

  def create_issue(%{issue: issue}, _) do
    with {:ok, %Issue{} = issue} <- Issues.create_issue(issue) do
      {:ok, %{issue: issue}}
    end
  end

  def list_issues(_, _, _) do
    {:ok, Track.Issues.list_issues()}
  end

  def get_issue(%{id: id}, _) do
    {:ok, Track.Issues.get_issue(id)}
  end

  def mark_issue_as(%{id: id, status: status}, _) do
    with {:ok, %Issue{} = issue} <- Issues.mark_issue_as(id, status) do
      {:ok, %{issue: issue}}
    end
  end
end
