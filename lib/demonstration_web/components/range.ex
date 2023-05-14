defmodule DemonstrationWeb.Components.Range do
  use DemonstrationWeb, :live_component

  @default_quantity 1
  @one_unit_price_in_cents 49 * 100

  def render(assigns) do
    assigns =
      assigns
      |> assign_new(:form, fn -> to_form(%{"quantity" => @default_quantity}) end)
      |> assign_new(:price_in_cents, fn -> @default_quantity * @one_unit_price_in_cents end)
      |> assign_new(:min_quantity, fn -> 1 end)
      |> assign_new(:max_quantity, fn -> 10 end)

    ~H"""
    <div class="mt-20 grid grid-cols-2 w-full bg-sky-500 p-8 rounded-md text-slate-800">
      <div class="space-y-2">
        <div class="text-2xl font-semibold text-slate-50">Special offers for existing customers</div>
        <p class="text-sky-800 font-semibold text-sm">
          Already a customer? You can renew or extend your license for less.
        </p>
        <p class="text-slate-50 text-sm">Learn about other ways to renew your license</p>
      </div>
      <div class="m-[-100px_0_-100px_0]">
        <.renew_license_card
          form={@form}
          myself={@myself}
          price_in_cents={@price_in_cents}
          min_quantity={@min_quantity}
          max_quantity={@max_quantity}
        />
      </div>
    </div>
    """
  end

  defp renew_license_card(assigns) do
    ~H"""
    <div class="flex flex-col gap-2 w-full -top-12 bg-slate-200 p-8 rounded-md text-sm">
      <div class="text-slate-950 font-semibold">Renew your license</div>
      <p class="text-slate-600">
        You currently have <span class="font-bold">2</span> seats with your license.
      </p>
      <.form
        for={@form}
        phx-submit="save"
        phx-change="validate"
        phx-target={@myself}
        class="flex flex-col bg-slate-300 gap-4 p-4 rounded-sm divide-y divide-solid"
      >
        <div class="flex flex-row justify-between border-slate-900">
          <div class="uppercase font-semibold">License volume</div>
          <.input
            id="disabled-input"
            type="text"
            field={@form[:quantity]}
            value={@form[:quantity].value}
            class="w-12 h-6 text-center border-none rounded-md"
            disabled
          />
        </div>
        <div class="">
          <.input
            id="range-input"
            type="range"
            field={@form[:quantity]}
            min={@min_quantity}
            max={@max_quantity}
            class="cursor-pointer mt-4 w-full"
          />
        </div>
        <div class="flex flex-row justify-between">
          <div class="text-2xl"><%= to_dollar(@price_in_cents) %></div>
          <p class="w-32">This price is only available to existing customer.</p>
        </div>
        <.button
          class="bg-sky-500 hover:bg-sky-600 py-2 px-3 rounded-lg text-sm font-semibold leading-6 text-white active:text-white/80 uppercase"
          type="submit"
        >
          Renew License
        </.button>
      </.form>
    </div>
    """
  end

  def handle_event("save", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"quantity" => quantity} = params, socket) do
    socket =
      socket
      |> assign(form: to_form(params))
      |> assign(price_in_cents: String.to_integer(quantity) * @one_unit_price_in_cents)

    {:noreply, socket}
  end

  defp to_dollar(price_in_cents) do
    "$#{round(price_in_cents / 100)}"
  end
end
