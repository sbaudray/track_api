defmodule TrackWeb.UserController do
  use TrackWeb, :controller

  def login(conn, %{"email" => email, "password" => password}) do
    case Track.Accounts.authenticate_by_email_and_password(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> render("show.json", %{user: user})

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{data: %{message: "Unauthorized"}})
    end
  end
end
