defmodule TrackWeb.Schema.IssuesTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object(:issue) do
    field(:title, non_null(:string))
    field(:body, non_null(:string))
    field(:status, non_null(:issue_status))

    field(:author, non_null(:user))
  end

  input_object(:issue_input) do
    field(:title, non_null(:string))
    field(:body, non_null(:string))
    field(:status, non_null(:issue_status))
    field(:author_id, non_null(:id))
  end

  enum :issue_status do
    value(:open, as: "open")
    value(:closed, as: "closed")
  end
end
