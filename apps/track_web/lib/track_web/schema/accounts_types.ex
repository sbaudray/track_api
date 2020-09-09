defmodule TrackWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:username, :string)
  end
end
