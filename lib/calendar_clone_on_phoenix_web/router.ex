defmodule CalendarCloneOnPhoenixWeb.Router do
  use CalendarCloneOnPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :maybe_browser_auth do
    plug(Guardian.Plug.VerifySession)
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(Guardian.Plug.LoadResource)
  end

  pipeline :ensure_authed_access do
    plug(Guardian.Plug.EnsureAuthenticated, %{"type" => "access", handler: CalendarCloneOnPhoenix.HttpErrorHandler})
  end

  scope "/", CalendarCloneOnPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController, only: [:new, :create]
  end

  scope "/", CalendarCloneOnPhoenixWeb do
    pipe_through([:browser, :maybe_browser_auth])

    get("/login", LoginController, :new)
    post("/login", LoginController, :create)
    delete("/login", LoginController, :delete)
  end

  scope "/", CalendarCloneOnPhoenixWeb do
    pipe_through([:browser, :maybe_browser_auth, :ensure_authed_access])

    resources "/app/calendar", CalendarController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", CalendarCloneOnPhoenixWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CalendarCloneOnPhoenixWeb.Telemetry
    end
  end
end
