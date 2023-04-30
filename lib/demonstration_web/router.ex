defmodule DemonstrationWeb.Router do
  use DemonstrationWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {DemonstrationWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", DemonstrationWeb do
    pipe_through(:browser)

    get("/", PageController, :home)

    live("/infinite-scroll", InfiniteScrollLive, :infinite_scroll)
    live("/copy-to-clipboard", CopyToClipboardLive, :copy_to_clipboard)
    live("/loader", LoaderLive, :loader)

    live_dashboard("/dashboard", metrics: DemonstrationWeb.Telemetry)

    get("/*path", PageController, :not_found)
  end

  # Other scopes may use custom stacks.
  # scope "/api", DemonstrationWeb do
  #   pipe_through :api
  # end
end
