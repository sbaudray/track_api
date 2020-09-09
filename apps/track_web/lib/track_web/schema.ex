defmodule TrackWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  import Absinthe.Schema.Notation
  alias TrackWeb.Resolvers

  import_types(TrackWeb.Schema.IssuesTypes)
  import_types(TrackWeb.Schema.AccountsTypes)

  node interface do
    resolve_type(fn
      %Track.Issues.Issue{}, _ -> :issue
      _, _ -> nil
    end)
  end

  enum :issue_status_type do
    value(:opened, as: "opened")
    value(:closed, as: "closed")
  end

  query do
    node field do
      resolve(fn
        %{type: :issue, id: id}, _ ->
          TrackWeb.Resolvers.Issues.find(%{id: id})
      end)
    end

    field :issues, non_null(list_of(:issue)) do
      resolve(&Resolvers.Issues.list_issues/3)
    end

    field :issue, :issue do
      arg(:id, non_null(:id))
      resolve(parsing_node_ids(&Resolvers.Issues.get_issue/2, id: :issue))
    end
  end

  mutation do
    payload field(:mark_issue_as) do
      input do
        field(:id, non_null(:id))
        field(:status, non_null(:issue_status_type))
      end

      output do
        field(:issue, :issue)
      end

      resolve(parsing_node_ids(&Resolvers.Issues.mark_issue_as/2, id: :issue))
    end
  end
end
