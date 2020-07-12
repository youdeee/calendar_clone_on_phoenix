defmodule CalendarCloneOnPhoenix.Accounts.EnsureNotAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :calendar_clone_on_phoenix,
    module: CalendarCloneOnPhoenix.Accounts.Guardian,
    error_handler: CalendarCloneOnPhoenix.Accounts.EnsureNotAuthErrorHandler

  plug Guardian.Plug.EnsureNotAuthenticated
end
