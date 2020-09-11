defmodule TrackWeb.Context do
  @behaviour Plug

  alias Track.Accounts
  alias Track.Accounts.User

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    with user_id when not is_nil(user_id) <- get_session(conn, :user_id),
         %User{} = user <- Accounts.get_user(user_id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
