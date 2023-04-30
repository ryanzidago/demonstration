defmodule DemonstrationWeb.LocalDateTimeLive do
  @doc """
  https://fly.io/phoenix-files/dates-formatting-with-hooks/
  """
  use DemonstrationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center">
      <.local_time utc_date_time={DateTime.utc_now()} id="user-local-time" />
    </div>
    """
  end

  attr(:utc_date_time, DateTime, required: true)
  attr(:id, :string, required: true)

  defp local_time(%{utc_date_time: %DateTime{}, id: id} = assigns)
       when is_binary(id) do
    ~H"""
    <div class="bg-yellow-300 font-semibold p-4 rounded-lg">
      <time id={@id} phx-hook="LocalTime" class="invisible">
        <%= @utc_date_time %>
      </time>
    </div>
    """
  end
end
