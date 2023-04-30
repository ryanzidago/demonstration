defmodule DemonstrationWeb.Components.GalleryComponent do
  use DemonstrationWeb, :live_component

  attr(:images, :list, required: true, doc: "The images to display in the gallery")
  attr(:page, :integer, required: true)

  def render(assigns) do
    ~H"""
    <div>
      <div id="infinite-scroll-body" phx-update="append" class="grid grid-cols-3 gap-2">
        <a
          :for={image <- @images}
          id={"image-#{random_id()}"}
          href={image}
          target="_blank"
          class="cursor-pointer duration-1000 hover:scale-150 hover:z-10"
        >
          <img src={image} />
        </a>
      </div>
      <div id="infinite-scroll-marker" phx-hook="InfiniteScroll" data-page={@page}></div>
    </div>
    """
  end

  defp random_id, do: Enum.random(0..1_000_000)
end
