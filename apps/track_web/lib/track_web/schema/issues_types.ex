defmodule TrackWeb.Schema.IssuesTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object(:issue) do
    field(:title, non_null(:string))
    field(:body, non_null(:string))
    field(:status, non_null(:string))

    field(:author, non_null(:user))
  end
end
