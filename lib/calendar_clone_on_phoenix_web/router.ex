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
    plug :fetch_session
    plug :protect_from_forgery
  end

  pipeline :login_session do
    plug CalendarCloneOnPhoenix.Accounts.LoginSessionPipeline
  end

  pipeline :ensure_auth do
    plug CalendarCloneOnPhoenix.Accounts.EnsureAuthPipeline
  end

  pipeline :ensure_not_auth do
    plug CalendarCloneOnPhoenix.Accounts.EnsureNotAuthPipeline
  end

  pipeline :calendar_layout do
    plug :put_layout, {CalendarCloneOnPhoenixWeb.LayoutView, :calendar}
  end

  scope "/", CalendarCloneOnPhoenixWeb do
    pipe_through([:browser])

    get "/", PageController, :index
    get("/logout", SessionController, :delete)
  end

  scope "/", CalendarCloneOnPhoenixWeb do
    pipe_through([:browser, :login_session, :ensure_not_auth])

    resources "/users", UserController, only: [:new, :create]
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
  end

  scope "/", CalendarCloneOnPhoenixWeb do
    pipe_through([:browser, :login_session, :ensure_auth, :calendar_layout])

    resources "/app/calendar", CalendarController, only: [:index]
  end

  scope "/api", CalendarCloneOnPhoenixWeb do
    pipe_through([:api, :login_session, :ensure_auth])

    resources "/events", EventController, only: [:index, :create, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", CalendarCloneOnPhoenixWeb do

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
