defmodule TrackWeb.Router do
  use TrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug TrackWeb.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TrackWeb.Schema

    forward "/graphql", Absinthe.Plug, schema: TrackWeb.Schema

    scope "/user", TrackWeb do
      post "/login", UserController, :login
    end
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TrackWeb.Telemetry
    end
  end
end
