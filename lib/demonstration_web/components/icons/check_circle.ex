defmodule DemonstrationWeb.Components.Icons.CheckCircle do
  use Phoenix.Component

  attr :class, :any
  attr :fill, :string

  def render(assigns) do
    assigns =
      assigns
      |> assign_new(:fill, fn -> "currentColor" end)
      |> assign_new(:fill_rule, fn -> "evenodd" end)
      |> assign_new(:clip_rule, fn -> "evenodd" end)
      |> assign_new(:view_box, fn -> "0 0 20 20" end)
      |> assign_new(:class, fn -> "w-6 h-6" end)

    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox={@view_box}
      fill={@fill}
      aria-hidden="true"
      class={@class}
    >
      <path
        fill-rule={@fill_rule}
        d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
        clip-rule={@clip_rule}
      />
    </svg>
    """
  end
end
