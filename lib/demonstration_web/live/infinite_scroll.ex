defmodule DemonstrationWeb.InfiniteScrollLive do
  @doc """
  https://fly.io/phoenix-files/infinitely-scroll-images-in-liveview/
  """
  use DemonstrationWeb, :live_view

  alias DemonstrationWeb.Components.GalleryComponent

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, page: 1)
    # temporary_assigns tells us that the value will reset after every render
    {:ok, socket, temporary_assigns: [images: []]}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="my-4">
      <GalleryComponent.render images={@images} page={@page} />
    </section>
    """
  end

  @impl true
  def handle_event("load-more", _params, socket) do
    socket =
      socket
      |> update(:page, &(&1 + 1))
      |> assign(images: images())

    {:noreply, socket}
  end

  defp images do
    ~W(
      https://images.unsplash.com/photo-1682406826663-1b26f0483be4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxODZ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682588942214-10758e7313ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNjJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682258688478-d223821e7b01?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNDV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682533945500-9e7012432f75?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMzJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682613375621-c10d167c852e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMTd8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682641188629-43e045412762?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5OHx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682371788431-e2bf837f868e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3OHx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682553064442-272b63b5a541?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2MXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682547095156-65970db2ec04?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1N3x8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682752013437-c4c775a78918?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1MXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1682752013334-0badd97a586d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0NHx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1681235854123-cf7a94b0e534?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1341&q=80
      https://plus.unsplash.com/premium_photo-1676654936157-90b146cbfd1c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80
      https://images.unsplash.com/photo-1682074905426-8b944309c1cc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80
      https://images.unsplash.com/photo-1681860317700-1b033c2c2a9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80
      https://images.unsplash.com/photo-1682258687337-9d2ca99054cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80
      https://images.unsplash.com/photo-1682552954728-bebadc9b9030?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80
      https://images.unsplash.com/photo-1682547095197-5d83eafdb271?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60
      https://images.unsplash.com/photo-1572853566605-af9816b0a77a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1227&q=80
    )
    |> Enum.shuffle()
  end
end
