defmodule CalendarCloneOnPhoenixWeb.CalendarController do
  use CalendarCloneOnPhoenixWeb, :controller
  # use Guardian.Phoenix.Controller

  def index(conn, params, user, claims) do
    render(conn, "index.html")
  end
end
