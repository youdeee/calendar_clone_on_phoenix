defmodule CalendarCloneOnPhoenixWeb.EventController do
  use CalendarCloneOnPhoenixWeb, :controller

  alias CalendarCloneOnPhoenix.Accounts
  alias CalendarCloneOnPhoenix.Accounts.Event

  def index(conn, params, user) do
    events = Accounts.list_events(user.id)
    json(conn, events)
  end

  def create(conn, params, user) do
    case Accounts.create_event(user.id, params) do
      {:ok, event} ->
        conn
        |> json(event)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: "Unexpected Error"})
    end
  end

  def update(conn, params, user) do
    event = Accounts.get_event!(user.id, params["id"])

    case Accounts.update_event(event, Map.delete(params, "id")) do
      {:ok, event} ->
        conn
        |> json(event)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: "Unexpected Error"})
    end
  end

  def delete(conn, %{"id" => id}, user) do
    event = Accounts.get_event!(user.id, id)
    {:ok, _event} = Accounts.delete_event(event)

    send_resp(conn, :no_content, "")
  end
end
