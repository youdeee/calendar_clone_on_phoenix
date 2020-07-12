defmodule CalendarCloneOnPhoenixWeb.SessionController do
  use CalendarCloneOnPhoenixWeb, :controller

  alias CalendarCloneOnPhoenix.{Accounts, Accounts.User, Accounts.Guardian}

  def new(conn, _params) do
    if Guardian.Plug.authenticated?(conn) do
      redirect(conn, to: Routes.calendar_path(conn, :index))
    else
      changeset = Accounts.change_user(%User{})
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Accounts.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.calendar_path(conn, :index))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
