defmodule TrackWeb.UserView do
  use TrackWeb, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, TrackWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{username: user.username, email: user.email}
  end
end
