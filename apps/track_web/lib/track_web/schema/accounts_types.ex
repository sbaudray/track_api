defmodule TrackWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object :user do
    field(:id, non_null(:id))
    field(:email, non_null(:string))
    field(:username, non_null(:string))
  end
end
