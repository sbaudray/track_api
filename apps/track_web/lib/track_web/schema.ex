defmodule TrackWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  import Absinthe.Schema.Notation
  alias Absinthe.Relay.Node
  alias TrackWeb.Resolvers
  alias Track.Accounts.User

  import_types(TrackWeb.Schema.IssuesTypes)
  import_types(TrackWeb.Schema.AccountsTypes)

  node interface do
    resolve_type(fn
      %Track.Issues.Issue{}, _ -> :issue
      %Track.Accounts.User{}, _ -> :user
      _, _ -> nil
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :issue, id: id}, _ ->
          TrackWeb.Resolvers.Issues.find(%{id: id})

        %{type: :user, id: id}, _ ->
          TrackWeb.Resolvers.Accounts.find_user(%{id: id})
      end)
    end

    field :issues, non_null(list_of(:issue)) do
      resolve(&Resolvers.Issues.list_issues/3)
    end

    field :issue, :issue do
      arg(:id, non_null(:id))
      middleware(Node.ParseIDs, id: :issue)
      resolve(&Resolvers.Issues.get_issue/2)
    end

    field :me, :me do
      resolve(&Resolvers.Accounts.me/2)
    end
  end

  mutation do
    payload field(:mark_issue_as) do
      input do
        field(:id, non_null(:id))
        field(:status, non_null(:issue_status))
      end

      output do
        field(:issue, :issue)
      end

      middleware(Node.ParseIDs, id: :issue)

      resolve(&Resolvers.Issues.mark_issue_as/2)
    end

    payload field(:create_issue) do
      input do
        field(:issue, non_null(:issue_input))
      end

      output do
        field(:issue, :issue)
      end

      middleware(Node.ParseIDs, issue: [author_id: :user])

      resolve(&Resolvers.Issues.create_issue/2)
    end

    payload field(:login) do
      input do
        field(:email, non_null(:string))
        field(:password, non_null(:string))
      end

      output do
        field(:user, :user)
        field(:result_errors, list_of(non_null(:login_result_error)))
      end

      resolve(&Resolvers.Accounts.login/2)

      middleware(fn resolution, _ ->
        with %{value: %{user: %User{} = user}} <- resolution do
          Map.update!(resolution, :context, fn ctx ->
            Map.put(ctx, :login_user_id, user.id)
          end)
        end
      end)
    end

    payload field(:logout) do
      output do
        field(:ok, :boolean)
      end

      resolve(fn _, _ -> {:ok, %{ok: true}} end)

      middleware(fn resolution, _ ->
        Map.update!(resolution, :context, fn ctx ->
          Map.put(ctx, :logout, true)
        end)
      end)
    end
  end
end
