defmodule TrackWeb.Router do
  use TrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug TrackWeb.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: TrackWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send}

    forward "/", Absinthe.Plug,
      schema: TrackWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send}
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

  def absinthe_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
    cond do
      user_id = blueprint.execution.context[:login_user_id] ->
        put_session(conn, :user_id, user_id)

      _logout = blueprint.execution.context[:logout] ->
        conn |> clear_session() |> configure_session(drop: true)

      true ->
        conn
    end
  end

  def absinthe_before_send(conn, _) do
    conn
  end
end
