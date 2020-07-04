# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :calendar_clone_on_phoenix,
  ecto_repos: [CalendarCloneOnPhoenix.Repo]

# Configures the endpoint
config :calendar_clone_on_phoenix, CalendarCloneOnPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cll1nGst1HoM1SaYtiF/Ns3lnHCin4I8wCvD5NtESw5SnuSoOGIFbtZG/dgFi0cQ",
  render_errors: [view: CalendarCloneOnPhoenixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CalendarCloneOnPhoenix.PubSub,
  live_view: [signing_salt: "3etPx1tM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian,
  issuer: "CalendarCloneOnPhoenix",
  secret_key: Mix.env(),
  serializer: CalendarCloneOnPhoenix.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
