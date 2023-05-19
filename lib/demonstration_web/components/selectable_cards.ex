defmodule DemonstrationWeb.Components.SelectableCards do
  use DemonstrationWeb, :live_component

  alias DemonstrationWeb.Components.Icons

  @impl true
  def mount(socket) do
    socket =
      socket
      |> assign_new(:plans, fn -> plans() end)
      |> assign(plans: plans())

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-zinc-300 w-full p-6 rounded-sm">
      <div class="flex flex-row justify-between items-baseline mb-4">
        <div class="text-xl text-zinc-950">
          Change plan:
        </div>
        <div class="text-sm text-zinc-900">
          <a href="">Cancel your plan</a>
        </div>
      </div>
      <div class="flex flex-row justify-center gap-4 mb-4">
        <.plan
          :for={plan <- @plans}
          plan_id={plan.id}
          title={plan.title}
          capacity={plan.capacity}
          price_per_month={plan.price_per_month}
          selected={plan.selected}
          myself={@myself}
        />
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("select", %{"plan_id" => id}, socket) do
    id = String.to_existing_atom(id)

    socket =
      update(socket, :plans, fn plans ->
        Enum.map(plans, fn
          plan when plan.id == id -> %{plan | selected: true}
          plan when plan.selected -> %{plan | selected: false}
          plan -> plan
        end)
      end)

    {:noreply, socket}
  end

  defp plan(assigns) do
    ~H"""
    <button
      phx-click="select"
      phx-target={@myself}
      phx-value-plan_id={@plan_id}
      class={[
        "bg-zinc-50 rounded-md p-4 cursor-pointer drop-shadow-lg w-full",
        if(@selected,
          do: "bg-emerald-400/60",
          else: "hover:bg-emerald-200/60 duration-500"
        )
      ]}
    >
      <div class={[
        "flex flex-row justify-between font-semibold text-zinc-700",
        if(@selected, do: "text-emerald-700")
      ]}>
        <div><%= @title %></div>
        <div :if={@selected}><Icons.CheckCircle.render class="w-6 h-6 text-emerald-700" /></div>
      </div>
      <div class="text-2xl"><%= @capacity %></div>
      <div>
        <span class={[if(@selected, do: "text-emerald-700")]}>$</span>
        <span class="font-semibold"><%= @price_per_month %></span>
        <span class={if(@selected, do: "text-emerald-700")}> / mo</span>
      </div>
    </button>
    """
  end

  defp plans do
    [
      %{
        id: :hobby,
        title: "Hobby",
        capacity: "1 GB",
        price_per_month: "5",
        selected: false
      },
      %{
        id: :growth,
        title: "Growth",
        capacity: "5 GB",
        price_per_month: "10",
        selected: false
      },
      %{
        id: :business,
        title: "Business",
        capacity: "10 GB",
        price_per_month: "15",
        selected: true
      },
      %{
        id: :enterprise,
        title: "Enterprise",
        capacity: "20 GB",
        price_per_month: "20",
        selected: false
      }
    ]
  end
end
