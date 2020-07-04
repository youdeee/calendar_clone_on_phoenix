defmodule CalendarCloneOnPhoenixWeb.PageController do
  use CalendarCloneOnPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
