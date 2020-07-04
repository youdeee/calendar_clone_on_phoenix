defmodule CalendarCloneOnPhoenixWeb.UserController do
  use CalendarCloneOnPhoenixWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, _params) do
  end
end
