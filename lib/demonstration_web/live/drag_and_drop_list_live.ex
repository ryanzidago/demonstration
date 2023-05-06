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
      %{name: "Lentils", id: 5, status: :in_progress}
    ]

    {:ok, assign(socket, shopping_list: list)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id="lists" class="">
      <.live_component
        id="shopping-list"
        module={ListComponent}
        list={@shopping_list}
        list_name="Shopping List"
      />
    </div>
    """
  end

  def id, do: Enum.random(0..1_000_000)
end

defmodule DemonstrationWeb.Components.ListComponent do
  use DemonstrationWeb, :live_component

  import DemonstrationWeb.CoreComponents

  @impl true
  def render(assigns) do
    assigns =
      assigns
      |> assign_new(:form, fn -> to_form(%{"name" => ""}) end)
      |> assign_new(:rename_form, fn -> to_form(%{"name" => "", "id" => nil}) end)
      |> assign_new(:rename_item, fn -> nil end)

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
            <.input field={@form["name"]} type="text" id="create-item-input" class="border-none" />
          </.form>
        </.header>

        <div phx-hook="DoubleClick" id="double-click">
          <div
            id={"#{@id}-items"}
            phx-hook="Sortable"
            data-drag_class="bg-sky-500"
            data-ghost_class="bg-sky-200"
            class="flex flex-col gap-2"
          >
            <div
              :for={item <- @list}
              id={"#{@id}-#{item.id}"}
              class={[
                "flex rounded-md border-2 border-zinc-200 hover:bg-sky-500 cursor-grab"
              ]}
            >
              <button
                type="button"
                phx-click="mark_as_complete"
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
              <div
                data-double_click_item_id={item.id}
                class={[
                  "flex-auto block text-sm leading-6 text-zinc-900"
                ]}
              >
                <%= if @rename_item == item.id do %>
                  <.form
                    for={@rename_form}
                    phx-target={@myself}
                    phx-submit="rename_submit"
                    phx-change="rename_change"
                    phx-click-away="rename_form_click_away"
                    class="flex flex-row gap-4 items-center cursor-text"
                  >
                    <.input
                      field={@rename_form["name"]}
                      id={"rename-item-input-#{item.id}"}
                      type="text"
                    />
                    <%= Phoenix.HTML.Form.hidden_input(@rename_form, "id", value: item.id) %>
                  </.form>
                <% else %>
                  <%= item.name %>
                <% end %>
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

  def handle_event("mark_as_complete", %{"id" => id}, socket) do
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
        [%{name: name, id: id(), status: :in_progress} | list]
      end)
      |> assign(form: %{"name" => ""})
      |> assign(rename_item: nil)

    {:noreply, socket}
  end

  def handle_event("change", %{"name" => name}, socket) do
    socket =
      socket
      |> assign(form: to_form(%{"name" => name}))

    {:noreply, socket}
  end

  def handle_event(
        "rename_submit",
        %{"name" => name, "id" => id},
        socket
      ) do
    socket =
      socket
      |> update(:list, fn list ->
        Enum.map(list, fn item ->
          if to_string(item.id) == id, do: Map.put(item, :name, name), else: item
        end)
      end)
      |> assign(form: %{"name" => ""})
      |> assign(rename_item: nil)

    {:noreply, socket}
  end

  def handle_event("rename_change", %{"name" => name, "id" => id} = _params, socket) do
    socket =
      socket
      |> assign(rename_form: to_form(%{"name" => name, "id" => id}))

    {:noreply, socket}
  end

  def handle_event("double_click", %{"id" => id}, socket) do
    socket = assign(socket, rename_item: id, rename_form: to_form(%{"name" => "", "id" => id}))
    {:noreply, socket}
  end

  def handle_event("rename_form_click_away", _, socket) do
    socket = assign(socket, rename_item: nil, rename_form: to_form(%{"name" => "", "id" => ""}))
    {:noreply, socket}
  end

  defp toggle_status(item) when is_map(item) do
    Map.update(item, :status, :in_progress, fn
      :in_progress -> :complete
      :complete -> :in_progress
    end)
  end

  def id, do: Enum.random(0..1_000_000)
end
