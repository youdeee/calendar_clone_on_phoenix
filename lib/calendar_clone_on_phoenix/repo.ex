defmodule CalendarCloneOnPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :calendar_clone_on_phoenix,
    adapter: Ecto.Adapters.MyXQL
end
