defmodule CalendarCloneOnPhoenix.Accounts.LoginSessionPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :calendar_clone_on_phoenix,
    module: CalendarCloneOnPhoenix.Accounts.Guardian,
    error_handler: CalendarCloneOnPhoenix.Accounts.ErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
end
