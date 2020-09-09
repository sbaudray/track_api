defmodule Track.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :title, :string
      add :body, :string
      add :status, :string
      add :author_id, references("users")

      timestamps()
    end
  end
end
