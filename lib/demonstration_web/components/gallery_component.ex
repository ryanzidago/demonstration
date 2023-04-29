defmodule DemonstrationWeb.Components.GalleryComponent do
  use DemonstrationWeb, :live_component

  defp random_id, do: Enum.random(1..1_000_000)

  def render(assigns) do
    ~H"""
    <div>
      <div id="infinite-scroll-bdoy" phx-update="append" class="grid grid-cols-3 gap-2">
        <img :for={image <- @images} id={"image-#{random_id()}"} src={image} />
      </div>
      <div id="infinite-scroll-marker" phx-hook="InfiniteScroll" data-page={@page}></div>
    </div>
    """
  end
end
