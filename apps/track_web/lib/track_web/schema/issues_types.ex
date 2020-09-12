defmodule TrackWeb.Schema.IssuesTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object(:issue) do
    field(:title, non_null(:string))
    field(:body, non_null(:string))
    field(:status, non_null(:issue_status_type))

    field(:author, non_null(:user))
  end

  enum :issue_status_type do
    value(:opened, as: "opened")
    value(:closed, as: "closed")
  end
end
