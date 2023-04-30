defmodule DemonstrationWeb.UserAgentLive do
  @doc """
  https://fly.io/phoenix-files/pass-user-agent-info-to-your-liveview/
  """
  use DemonstrationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, device: parse_user_agent(socket))
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center">
      <div class="text-white text-xl">Device: <%= @device %></div>
    </div>
    """
  end

  defp parse_user_agent(socket) do
    result =
      socket
      |> get_connect_info(:user_agent)
      |> UAParser.parse()

    case result do
      %UAParser.UA{device: %UAParser.Device{family: fam}} -> fam
      _ -> "I don't know your device"
    end
  end
end
