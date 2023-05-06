defmodule DemonstrationWeb.DragAndDropListLive do
  @doc """
  https://fly.io/phoenix-files/liveview-drag-and-drop/
  """
  use DemonstrationWeb, :live_view
  alias DemonstrationWeb.Components.ListComponent

  @impl true
  def mount(_params, _session, socket) do
    list = [
      %{name: "Bread", id: 1, status: :in_progress},
      %{name: "Beans", id: 2, status: :in_progress},
      %{name: "Almond Milk", id: 3, status: :in_progress},
      %{name: "Bananas", id: 4, status: :in_progress},
      %{name: "Tofu", id: 5, status: :in_progress}
    ]

    {:ok, assign(socket, shopping_list: list)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id="lists" class="">
      <.live_component
        form={%{"name" => ""}}
        id="1"
        module={ListComponent}
        list={@shopping_list}
        list_name="Shopping List"
      />
    </div>
    """
  end
end

defmodule DemonstrationWeb.Components.ListComponent do
  use DemonstrationWeb, :live_component

  import DemonstrationWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-gray-100 py-4 rounded-lg">
      <div class="space-y-5 px-4">
        <.header>
          <%= @list_name %>
          <.form
            for={@form}
            phx-target={@myself}
            phx-change="change"
            phx-submit="submit"
            class="flex flex-row gap-4 items-center "
          >
            <.input
              field={@form["name"]}
              name="name"
              value={@form["name"]}
              type="text"
              class="border-none"
            />
            <%!-- <button class="bg-slate-900 rounded-md text-slate-50">
              <.icon name="hero-plus" />
            </button> --%>
          </.form>
        </.header>

        <div
          id={"#{@id}-items"}
          phx-hook="Sortable"
          data-list_id={@id}
          data-drag_class="bg-sky-500"
          data-ghost_class="bg-sky-200"
          class="flex flex-col gap-2"
        >
          <div
            :for={item <- @list}
            id={"#{@id}-#{item.id}"}
            class={[
              "rounded-md border-2 border-zinc-200 hover:bg-sky-500 cursor-pointer"
            ]}
          >
            <div class="flex">
              <button
                type="button"
                phx-click="mark-as-complete"
                phx-value-id={item.id}
                phx-target={@myself}
                class="w-10"
              >
                <.icon
                  name="hero-check-circle"
                  class={[
                    "w-7 h-7",
                    if(item.status == :complete, do: "bg-green-600", else: "bg-gray-300")
                  ]}
                />
              </button>
              <div class="flex-auto block text-sm leading-6 text-zinc-900 ">
                <%= item.name %>
              </div>
              <button type="button" class="w-10 -mt-1 flex none">
                <.icon name="hero-x-makr" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("reposition", %{"from" => from, "to" => to}, socket) do
    socket = update(socket, :list, fn list -> Enum.slide(list, from, to) end)
    {:noreply, socket}
  end

  def handle_event("mark-as-complete", %{"id" => id}, socket) do
    socket =
      update(socket, :list, fn list ->
        Enum.map(list, fn item ->
          if to_string(item.id) == id, do: toggle_status(item), else: item
        end)
      end)

    {:noreply, socket}
  end

  def handle_event("submit", _, %{assigns: %{form: %{"name" => name}}} = socket) do
    socket =
      socket
      |> update(:list, fn list ->
        [%{name: name, id: 6, position: 6, status: :in_progress} | list]
      end)
      |> assign(form: %{"name" => ""})

    {:noreply, socket}
  end

  def handle_event("change", %{"name" => name}, socket) do
    socket =
      socket
      |> assign(form: %{"name" => name})

    {:noreply, socket}
  end

  defp toggle_status(item) when is_map(item) do
    Map.update(item, :status, :in_progress, fn
      :in_progress -> :complete
      :complete -> :in_progress
    end)
  end
end
