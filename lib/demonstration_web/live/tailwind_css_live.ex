defmodule DemonstrationWeb.TailwindCSSLive do
  @moduledoc """

  """
  use DemonstrationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center space-y-28">
      <.list_1 />
      <.table_1 />
      <.form_1 />
      <.button_1 />
    </div>
    """
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
end
