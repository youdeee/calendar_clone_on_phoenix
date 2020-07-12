defmodule CalendarCloneOnPhoenix.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, default: "", null: false
      add :date, :date, null: false
      add :place, :string, default: "", null: false
      add :description, :text
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:events, [:user_id])
  end
end
