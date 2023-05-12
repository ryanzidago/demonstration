defmodule DemonstrationWeb.Components.Icons.UploadFile do
  use Phoenix.Component

  attr :class, :any
  attr :fill, :string

  def render(assigns) do
    assigns =
      assigns
      |> assign_new(:fill, fn -> "none" end)
      |> assign_new(:view_box, fn -> "0 0 24 24" end)
      |> assign_new(:stroke_width, fn -> "1.5" end)
      |> assign_new(:stroke, fn -> "currentColor" end)
      |> assign_new(:class, fn -> "w-6 h-6" end)

    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill={@fill}
      viewBox={@view_box}
      stroke-width={@stroke_width}
      stroke={@stroke}
      class={@class}
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M7.5 7.5h-.75A2.25 2.25 0 004.5 9.75v7.5a2.25 2.25 0 002.25 2.25h7.5a2.25 2.25 0 002.25-2.25v-7.5a2.25 2.25 0 00-2.25-2.25h-.75m0-3l-3-3m0 0l-3 3m3-3v11.25m6-2.25h.75a2.25 2.25 0 012.25 2.25v7.5a2.25 2.25 0 01-2.25 2.25h-7.5a2.25 2.25 0 01-2.25-2.25v-.75"
      />
    </svg>
    """
  end
end
