defmodule Track.Accounts do
  alias Track.Repo
  alias Track.Accounts.User
  import Ecto.Query

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_email_and_password(email, password) do
    query = from u in User, where: u.email == ^email

    with %User{} = user <- Repo.one(query),
         {:ok, verified_user} <- Argon2.check_pass(user, password) do
      {:ok, verified_user}
    else
      _ -> {:error, :unauthorized}
    end
  end
end
