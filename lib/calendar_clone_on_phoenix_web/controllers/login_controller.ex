defmodule CalendarCloneOnPhoenixWeb.LoginController do
  use CalendarCloneOnPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    case find_the_user_and_verify_them_from_params(params) do
      {:ok, user} ->
        # Use access tokens.
        # Other tokens can be used, like :refresh etc
        conn
        |> Guardian.Plug.sign_in(user, :access)
        |> IO.inspect # respond_somehow()

      {:error, reason} ->
        nil
        # handle not verifying the user's credentials
    end
  end

  def delete(conn, params) do
    conn
    |> Guardian.Plug.sign_out()
    |> IO.inspect # respond_somehow()
  end

  defp find_the_user_and_verify_them_from_params(params) do
  end
end
