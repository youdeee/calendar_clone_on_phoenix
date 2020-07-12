defmodule CalendarCloneOnPhoenix.Accounts.EnsureNotAuthErrorHandler do
  use CalendarCloneOnPhoenixWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> redirect(to: Routes.calendar_path(conn, :index))
  end
end
