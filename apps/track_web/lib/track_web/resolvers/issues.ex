defmodule TrackWeb.Resolvers.Issues do
  def find(%{id: id}) do
    {:ok, Track.Issues.get_issue(id)}
  end

  def list_issues(_, _, _) do
    {:ok, Track.Issues.list_issues()}
  end

  def get_issue(%{id: id}, _) do
    {:ok, Track.Issues.get_issue(id)}
  end

  def mark_issue_as(%{id: id, status: status}, _) do
    with {:ok, %Track.Issues.Issue{} = issue} <- Track.Issues.mark_issue_as(id, status) do
      {:ok, %{issue: issue}}
    end
  end
end
