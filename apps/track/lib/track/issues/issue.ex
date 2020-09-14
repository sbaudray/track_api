defmodule Track.Issues.Issue do
  use Ecto.Schema
  import Ecto.Changeset
  alias Track.Issues.Issue
  alias Track.Accounts.User

  schema "issues" do
    field :title, :string
    field :body, :string
    field :status, :string
    belongs_to :author, User

    timestamps()
  end

  @doc false
  def changeset(%Issue{} = issue, attrs) do
    issue
    |> cast(attrs, [:title, :body, :status, :author_id])
    |> validate_required([:title, :body, :status, :author_id])
    |> validate_inclusion(:status, ~w(open closed))
  end
end
