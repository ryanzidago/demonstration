defmodule DemonstrationWeb.TailwindCSSLive do
  @moduledoc """

  """
  use DemonstrationWeb, :live_view
  alias DemonstrationWeb.Components.ListComponent
  alias DemonstrationWeb.Components.FileUploader

  @components ~w(list_1 table_1 form_1 button_1 fieldset_1 drag_and_drop_list_1 doughnut_chart_1 line_chart_1 file_uploader_1)

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, component: "list_1")
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, _, params) do
    component = Map.get(params, "component")
    component = if component in @components, do: component, else: "list_1"
    assign(socket, component: component)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="relative">
      <button
        phx-click="previous"
        class="fixed lg:top-20 md:top-4 lg:left-[20%] md:left-[35%] bg-sky-500 hover:bg-sky-600 py-2 px-4 rounded-full ont-sm text-slate-50 drop-shadow-lg duration-200 w-28"
      >
        Previous
      </button>
      <div class="flex flex-col items-center justify-center">
        <.list_1 :if={@component == "list_1"} />
        <.table_1 :if={@component == "table_1"} />
        <.form_1 :if={@component == "form_1"} />
        <.button_1 :if={@component == "button_1"} />
        <.fieldset_1 :if={@component == "fieldset_1"} />
        <.drag_and_drop_list_1 :if={@component == "drag_and_drop_list_1"} />
        <.doughnut_chart_1 :if={@component == "doughnut_chart_1"} />
        <.line_chart_1 :if={@component == "line_chart_1"} />
        <.file_uploader_1 :if={@component == "file_uploader_1"} />
      </div>
      <button
        phx-click="next"
        class="fixed lg:top-20 md:top-4 lg:right-[20%] md:right-[35%] bg-sky-500 hover:bg-sky-600  py-2 px-4 rounded-full ont-sm text-slate-50 drop-shadow-lg duration-200 w-28"
      >
        Next
      </button>
    </div>
    """
  end

  @impl true
  def handle_event("previous", _params, socket) do
    index = Enum.find_index(@components, &(&1 == socket.assigns.component))
    component = Enum.at(@components, index - 1)

    socket =
      socket
      |> assign(component: component)
      |> push_patch(to: ~p{/tailwind-css?component=#{component}})

    {:noreply, socket}
  end

  def handle_event("next", _params, socket) do
    index = Enum.find_index(@components, &(&1 == socket.assigns.component))
    component = Enum.at(@components, rem(index + 1, length(@components)))

    socket =
      socket
      |> assign(component: component)
      |> push_patch(to: ~p{/tailwind-css?component=#{component}})

    {:noreply, socket}
  end

  def list_1(assigns) do
    people = [
      %{
        profile_picture_url:
          "https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
        first_name: "Kirsten",
        last_name: "Ramos",
        email: "kristen.ramos@example.com",
        phone: ""
      },
      %{
        profile_picture_url:
          "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
        first_name: "Floyd",
        last_name: "Miles",
        email: "floyd.miles@example.com",
        phone: ""
      },
      %{
        profile_picture_url:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
        first_name: "Courtney",
        last_name: "Henry",
        email: "courtney.henry@example.com",
        phone: ""
      },
      %{
        profile_picture_url:
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
        first_name: "Ted",
        last_name: "Fox",
        email: "ted.fox@example.com",
        phone: ""
      }
    ]

    assigns = assign(assigns, people: people)

    ~H"""
    <ul role="list" class="divide-y divide-slate-200 rounded-sm w-2/3">
      <li
        :for={person <- @people}
        class={[
          "flex flex-row justify-between p-6 bg-slate-50 first:rounded-t-md last:rounded-b-md group/item",
          "hover:bg-slate-100 hover:scale-105 hover:rounded-sm duration-500"
        ]}
      >
        <div class="flex">
          <img src={person.profile_picture_url} class="rounded-full w-10 h-10 drop-shadow-xl" />
          <div class="text-slate-500 ml-3">
            <p class="font-medium text-slate-900 truncate drop-shadow-lg">
              <%= "#{person.first_name} #{person.last_name}" %>
            </p>
            <p class="truncate">
              <a href={"mailto:#{person.email}"}><%= person.email %></a>
            </p>
          </div>
        </div>
        <a
          href={"tel:#{person.phone}"}
          class="flex items-center invisible group/call group-hover/item:visible rounded-full px-4 hover:bg-slate-200 hover:drop-shadow-md hover:duration-100"
        >
          <span class="text-slate-500 text-sm font-medium group-hover/call:text-gray-700 group-hover/call:drop-shadow-md">
            Call
          </span>
          <svg
            class="mt-px h-5 w-5 text-slate-400 transition group-hover/call:translate-x-0.5 group-hover/call:text-slate-700"
            viewBox="0 0 20 20"
            fill="currentColor"
          >
            <path
              fill-rule="evenodd"
              d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
              clip-rule="evenodd"
            >
            </path>
          </svg>
        </a>
      </li>
    </ul>
    """
  end

  def table_1(assigns) do
    people = [
      %{
        name: "Jane Cooper",
        title: "Regional Paradigm Technician",
        email: "jane.cooper@example.com"
      },
      %{
        name: "Cody Fisher",
        title: "Product Directives Officer ",
        email: "cody.fisher@example.com"
      },
      %{
        name: "Leonard Krasner",
        title: "Senior Designer",
        email: "leonard.krasner@example.com"
      },
      %{
        name: "Emily Selman",
        title: "VP, Hardware Engineering",
        email: "emily.selman@example.com"
      },
      %{
        name: "Anna Roberts",
        title: "Chief Strategy Officer",
        email: "anna.roberts@example.com"
      }
    ]

    assigns = assign(assigns, people: people)

    ~H"""
    <table class="bg-slate-50">
      <thead>
        <tr class="bg-slate-100">
          <td class="px-6 py-3 font-semibold text-slate-800 drop-shadow-sm">Name</td>
          <td class="px-6 py-3 font-semibold text-slate-800 drop-shadow-sm">Title</td>
          <td class="px-6 py-3 font-semibold text-slate-800 drop-shadow-sm">Email</td>
        </tr>
      </thead>
      <tbody>
        <tr :for={person <- @people} class="odd:bg-slate-50 even:bg-slate-100">
          <td class="px-6 py-3 font-medium text-slate-800 drop-shadow-sm"><%= person.name %></td>
          <td class="px-6 py-3 text-slate-600 drop-shadow-sm"><%= person.title %></td>
          <td class="px-6 py-3 text-slate-600 drop-shadow-sm"><%= person.email %></td>
        </tr>
      </tbody>
    </table>
    """
  end

  def form_1(assigns) do
    ~H"""
    <form class="bg-slate-50 px-8 pt-8 pb-4 rounded-sm">
      <label class="flex flex-col text-slate-600 gap-2">
        <span class="text-slate-800 drop-shadow-sm">Email</span>
        <input
          type="email"
          class="text-slate-800 peer border border-slate-200 drop-shadow-sm rounded-md "
        />
        <p class="invisible peer-invalid:visible text-sm text-pink-600">
          Please provide a valid email address
        </p>
      </label>
    </form>
    """
  end

  def button_1(assigns) do
    ~H"""
    <a
      href="#"
      target="_blank"
      class="group bg-slate-50 hover:bg-sky-500 p-6 rounded-md max-w-xs mx-auto hover:ring-2 hover:ring-sky-600 duration-200"
    >
      <div class="flex items-center gap-3">
        <svg
          class="h-6 w-6 stroke-sky-500 group-hover:stroke-slate-50"
          fill="none"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M11 19H6.931A1.922 1.922 0 015 17.087V8h12.069C18.135 8 19 8.857 19 9.913V11"
          >
          </path>
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M14 7.64L13.042 6c-.36-.616-1.053-1-1.806-1H7.057C5.921 5 5 5.86 5 6.92V11M17 15v4M19 17h-4"
          >
          </path>
        </svg>
        <h3 class="text-slate-900 text-sm font-semibold group-hover:text-slate-50">
          New Project
        </h3>
      </div>
      <p class="text-slate-500 text-sm mt-2 group-hover:text-slate-50">
        Create a new project from a variety of starting templates.
      </p>
    </a>
    """
  end

  def fieldset_1(assigns) do
    # for <input>, only one element of the type `radio` can be checked for the same name
    ~H"""
    <div id="fieldset-1" class="bg-slate-50 w-[70%] p-4 rounded-md">
      <fieldset class="flex items-center gap-2 space-y-4">
        <legend class="mb-6 w-full border-b border-slate-200 pb-2 text-base font-semibold text-slate-500 drop-shadow-sm">
          Published status
        </legend>

        <input
          id="draft"
          type="radio"
          name="status"
          class="appearance-none peer/draft border-1 border-slate-300 border focus:bg-sky-300 focus:ring-offset-slate-50 checked:bg-sky-300 drop-shadow-sm"
        />
        <label
          for="draft"
          class="font-sm text-slate-500 peer-checked/draft:text-sky-500 mr-2 drop-shadow-sm"
        >
          Draft
        </label>

        <input
          id="published"
          type="radio"
          name="status"
          class="appearance-none peer/published border-1 border-slate-300 focus:ring-sky-500 focus:ring-offset-slate-50 checked:bg-sky-300 drop-shadow-sm"
        />
        <label
          for="published"
          class="font-sm text-slate-500 peer-checked/published:text-sky-500 drop-shadow-sm  "
        >
          Published
        </label>
      </fieldset>
    </div>
    """
  end

  defp drag_and_drop_list_1(assigns) do
    assigns =
      assign(assigns,
        shopping_list: [
          %{name: "Bread", id: 1, status: :in_progress},
          %{name: "Beans", id: 2, status: :in_progress},
          %{name: "Almond Milk", id: 3, status: :in_progress},
          %{name: "Bananas", id: 4, status: :in_progress},
          %{name: "Lentils", id: 5, status: :in_progress}
        ]
      )

    ~H"""
    <.live_component
      id="shopping-list"
      module={ListComponent}
      list={@shopping_list}
      list_name="Shopping List"
    />
    """
  end

  defp doughnut_chart_1(assigns) do
    chart_data = [
      %{label: "Completed", colour: "hsl(220,95%,30%)", value: 35},
      %{label: "Assigned", colour: "hsl(220,65%,60%)", value: 40},
      %{label: "Due", colour: "hsl(220,70%,80%)", value: 25}
    ]

    assigns = assign(assigns, chart_data: chart_data)

    ~H"""
    <div class="bg-slate-50 rounded-md p-8 w-ful">
      <div class="flex flex-row space-x-10 items-end drop-shadow-sm">
        <.doughnut_chart_legend chart_data={@chart_data} />
        <div>
          <canvas class="h-20 w-20" id="doughnut-chart" phx-hook="DoughnutChart" />
        </div>
      </div>
    </div>
    """
  end

  defp doughnut_chart_legend(assigns) do
    ~H"""
    <legend id="doughnut-chart-legend" class="flex flex-col gap-2">
      <p class="font-semibold text-slate-800">Tasks</p>
      <div
        :for={data <- @chart_data}
        class="flex flex-row items-center gap-2 hover:scale-105 duration-300"
      >
        <div class={"#{background_colour(data.colour)} rounded-full h-4 w-4"} />
        <p class="text-sm text-slate-700">
          <%= data.label %> <span class="font-semibold">(<%= data.value %>%)</span>
        </p>
      </div>
    </legend>
    """
  end

  defp background_colour("hsl(220,95%,30%)"), do: "bg-[#043495]"
  defp background_colour("hsl(220,65%,60%)"), do: "bg-[#5783db]"
  defp background_colour("hsl(220,70%,80%)"), do: "bg-[#a8c0f0]"

  defp line_chart_1(assigns) do
    ~H"""
    <div class="bg-slate-50 rounded-md p-8 w-full">
      <div class="flex flex-row items-center justify-between">
        <legend>
          <p class="font-semibold text-slate-500">Monthly Revenue</p>
        </legend>
        <div class="rounded-full border-2 border-emerald-500 bg-emerald-100 px-3 text-center text-slate-600">
          1.4%
        </div>
      </div>
      <p class="font-semibold text-slate-600 text-2xl">$103K</p>
      <canvas id="line-chart" class="" phx-hook="LineChart" />
    </div>
    """
  end

  defp file_uploader_1(assigns) do
    ~H"""
    <.live_component id="file-uploader-1" module={FileUploader} />
    """
  end
end
