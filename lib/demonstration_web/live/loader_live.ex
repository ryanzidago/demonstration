defmodule DemonstrationWeb.LoaderLive do
  @doc """
  https://fly.io/phoenix-files/server-triggered-js/
  """
  use DemonstrationWeb, :live_view

  alias Phoenix.LiveView.JS

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, data_is_loading: false)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center space-y-24">
      <button
        phx-click={unless @data_is_loading, do: "load-data"}
        class={[
          "font-semibold text-white bg-red-500 p-4 rounded-md w-1/2",
          "hover:bg-red-700",
          "#{if @data_is_loading, do: "disabled cursor-progress"}"
        ]}
      >
        Click me to display the loader animation!
      </button>
      <.loader id="loader" />
    </div>
    """
  end

  attr(:id, :string, required: true)

  defp loader(assigns) do
    ~H"""
    <div
      class="hidden bg-transparent h-full bg-slate-100"
      id={@id}
      data-toggle-loader={toggle_loader("loader")}
    >
      <div class="flex justify-center items-center h-full">
        <div class="flower-spinner">
          <div class="dots-container">
            <div class="bigger-dot">
              <div class="smaller-dot"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("load-data", _, socket) do
    send(self(), :load_data)

    socket =
      socket
      |> assign(data_is_loading: true)
      |> push_event("js-exec", %{to: "#loader", attr: "data-toggle-loader"})

    {:noreply, socket}
  end

  def handle_info(:load_data, socket) do
    :timer.sleep(3_000)

    socket =
      socket
      |> assign(data_is_loading: false)
      |> push_event("js-exec", %{to: "#loader", attr: "data-toggle-loader"})

    {:noreply, socket}
  end

  defp toggle_loader(js \\ %JS{}, id) do
    JS.toggle(js,
      to: "##{id}",
      out: {"ease-out duration-300", "opacity-0", "opacity-100"},
      in: {"ease-in duration-300", "opacity-100", "opacity-0"}
    )
  end
end
