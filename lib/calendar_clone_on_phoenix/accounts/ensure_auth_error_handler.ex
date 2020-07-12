defmodule CalendarCloneOnPhoenix.Accounts.EnsureAuthErrorHandler do
  use CalendarCloneOnPhoenixWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
