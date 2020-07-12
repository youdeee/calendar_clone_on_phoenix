defmodule CalendarCloneOnPhoenixWeb.CalendarController do
  use CalendarCloneOnPhoenixWeb, :controller

  def index(conn, _params, _user) do
    render(conn, "index.html")
  end
end
