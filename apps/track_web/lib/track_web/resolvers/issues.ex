defmodule TrackWeb.Resolvers.Issues do
  def find(%{id: id}) do
    {:ok, Track.Issues.get_issue(id)}
  end

  def list_issues(_, _, _) do
    {:ok, Track.Issues.list_issues()}
  end
end
