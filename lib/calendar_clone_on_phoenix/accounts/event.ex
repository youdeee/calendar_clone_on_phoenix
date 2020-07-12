defmodule CalendarCloneOnPhoenix.Accounts.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:user_id, :name, :date, :place, :description]

  @derive {Jason.Encoder, only: [:id | @fields]}
  schema "events" do
    field :date, :date
    field :description, :string
    field :name, :string, default: ""
    field :place, :string, default: ""
    field :user_id, :id
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @fields)
    |> validate_required([:user_id, :date])
  end
end
