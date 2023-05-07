defmodule DemonstrationWeb.Components.ListComponent do
  @doc """
  https://fly.io/phoenix-files/liveview-drag-and-drop/
  """
  use DemonstrationWeb, :live_component

  import DemonstrationWeb.CoreComponents

  @impl true
  def render(assigns) do
    assigns =
      assigns
      |> assign_new(:create_form, fn -> to_form(%{"name" => ""}) end)
      |> assign_new(:update_form, fn -> to_form(%{"name" => "", "id" => nil}) end)
      |> assign_new(:update_item_with_id, fn -> nil end)

    ~H"""
    <div class="bg-gray-100 py-4 rounded-lg">
      <div class="space-y-5 px-4">
        <.header>
          <div class="drop-shadow-sm">
            <%= @list_name %>
          </div>
          <.form
            for={@create_form}
            phx-target={@myself}
            phx-change="create_change"
            phx-submit="create_submit"
            class="flex flex-row gap-4 items-center "
          >
            <.input
              field={@create_form[:name]}
              type="text"
              id="create-item-input"
              class="border-none rounded-md drop-shadow-sm focus:ring-2 focus:ring-sky-400 mt-2"
            />
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
                  " block text-sm leading-6 text-zinc-900 py-2"
                ]}
              >
                <%= if item.id == @update_item_with_id do %>
                  <.form
                    for={@update_form}
                    phx-target={@myself}
                    phx-submit="update_submit"
                    phx-change="update_change"
                    phx-click-away="hide_update_form"
                    phx-window-keydown="hide_update_form"
                    class="flex flex-row gap-4 items-center"
                  >
                    <.input
                      field={@update_form[:name]}
                      id={"rename-item-input-#{item.id}"}
                      type="text"
                      class="border-none rounded-md drop-shadow-sm focus:ring-2 focus:ring-sky-400 h-6 text-sm w-40"
                    />
                    <%= Phoenix.HTML.Form.hidden_input(@update_form, "id", value: item.id) %>
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

  def handle_event("create_submit", %{"name" => name}, socket) do
    socket =
      socket
      |> update(:list, fn list ->
        [%{name: name, id: id(), status: :in_progress} | list]
      end)
      |> assign(create_form: to_form(%{"name" => ""}))

    {:noreply, socket}
  end

  def handle_event("create_change", %{"name" => name}, socket) do
    socket =
      socket
      |> assign(create_form: to_form(%{"name" => name}))

    {:noreply, socket}
  end

  def handle_event(
        "update_submit",
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
      |> assign(update_form: to_form(%{"name" => ""}))
      |> assign(update_item_with_id: nil)

    {:noreply, socket}
  end

  def handle_event("update_change", %{"name" => name, "id" => id} = _params, socket) do
    socket =
      socket
      |> assign(update_form: to_form(%{"name" => name, "id" => id}))

    {:noreply, socket}
  end

  def handle_event("double_click", %{"id" => id}, socket) do
    socket =
      assign(socket, update_item_with_id: id, update_form: to_form(%{"name" => "", "id" => id}))

    {:noreply, socket}
  end

  def handle_event("hide_update_form", %{"key" => "Escape"}, socket) do
    socket =
      assign(socket, update_item_with_id: nil, update_form: to_form(%{"name" => "", "id" => ""}))

    {:noreply, socket}
  end

  def handle_event("hide_update_form", %{"key" => _key}, socket), do: {:noreply, socket}

  def handle_event("hide_update_form", _params, socket) do
    socket =
      assign(socket, update_item_with_id: nil, update_form: to_form(%{"name" => "", "id" => ""}))

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
