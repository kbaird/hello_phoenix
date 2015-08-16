defmodule HelloPhoenix.ZoidbergView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{zoidbergs: zoidbergs}) do
    %{data: render_many(zoidbergs, HelloPhoenix.ZoidbergView, "zoidberg.json")}
  end

  def render("show.json", %{zoidberg: zoidberg}) do
    %{data: render_one(zoidberg, HelloPhoenix.ZoidbergView, "zoidberg.json")}
  end

  def render("zoidberg.json", %{zoidberg: zoidberg}) do
    %{id: zoidberg.id}
  end
end
