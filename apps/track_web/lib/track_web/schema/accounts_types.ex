defmodule TrackWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object(:user) do
    field(:email, non_null(:string))
    field(:username, non_null(:string))
  end

  object :login_result_error do
    field(:message, non_null(:string))
  end

  object :me do
    field(:user, :user)
    field(:result_errors, list_of(:login_result_error))
  end
end
