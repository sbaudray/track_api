defmodule Track.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Track.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Track.PubSub}
      # Start a worker by calling: Track.Worker.start_link(arg)
      # {Track.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Track.Supervisor)
  end
end
