defmodule DemonstrationWeb.PageController do
  use DemonstrationWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def not_found(conn, _params) do
    conn
    |> put_status(:not_found)
    |> render(:not_found, layout: false)
  end
end
