defmodule CalendarCloneOnPhoenix.Accounts.EnsureAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :calendar_clone_on_phoenix,
    module: CalendarCloneOnPhoenix.Accounts.Guardian,
    error_handler: CalendarCloneOnPhoenix.Accounts.EnsureAuthErrorHandler

  plug Guardian.Plug.EnsureAuthenticated
  plug CalendarCloneOnPhoenix.Accounts.CurrentUser
end
