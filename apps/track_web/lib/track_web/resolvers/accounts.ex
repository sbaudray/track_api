defmodule TrackWeb.Resolvers.Accounts do
  alias Track.Accounts.User

  def login(%{email: email, password: password}, _) do
    with {:ok, %User{} = user} <-
           Track.Accounts.authenticate_by_email_and_password(email, password) do
      {:ok, %{user: user, result_errors: nil}}
    else
      _ -> {:ok, %{user: nil, result_errors: [%{message: :unauthorized}]}}
    end
  end

  def me(_, %{context: %{current_user: user}}) do
    {:ok, %{user: user, result_errors: nil}}
  end

  def me(_, _) do
    {:ok, %{user: nil, result_errors: [%{message: :unauthorized}]}}
  end
end
