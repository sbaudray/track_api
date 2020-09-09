defmodule Track.Accounts do
  alias Track.Repo
  alias Track.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
