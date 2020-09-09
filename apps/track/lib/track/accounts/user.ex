defmodule Track.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Track.Accounts.User
  alias Track.Issues.Issue

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :issues, Issue, foreign_key: :author_id

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
