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
  end
end
