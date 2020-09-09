# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :track,
  ecto_repos: [Track.Repo]

config :track_web,
  ecto_repos: [Track.Repo],
  generators: [context_app: :track]

# Configures the endpoint
config :track_web, TrackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Hcm/T43VtUvEXBiKngXXqg3S7zsBVyF9f3ow1WzwinkUPRc+DxjeTD6NU0F+pkMK",
  render_errors: [view: TrackWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Track.PubSub,
  live_view: [signing_salt: "vLNJ8SrM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
