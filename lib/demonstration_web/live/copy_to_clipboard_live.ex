defmodule DemonstrationWeb.CopyToClipboardLive do
  @doc """
  https://fly.io/phoenix-files/copy-to-clipboard-with-phoenix-liveview/
  """
  use DemonstrationWeb, :live_view

  alias Phoenix.LiveView.JS

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col space-y-8">
      <div class="flex flex-col items-center">
        <label class="text-white">JS Event Listener</label>
        <div class="w-1/2 rounded-md bg-white flex">
          <input
            id="control-codes"
            type="text"
            value="12345#qwerty"
            class="border-0 bg-cyan-400 rounded-l-md"
          />
          <button
            phx-click={JS.dispatch("phx:copy", to: "#control-codes")}
            class="bg-rose-200 rounded-r-md w-full"
          >
            <span> 📋 </span>
          </button>
        </div>
      </div>

      <div class="flex flex-col items-center">
        <label class="text-white">JS Hook</label>
        <div class="w-1/2 rounded-md bg-white flex">
          <input
            id="control-codes-hook"
            type="text"
            value="67890#asdfgh"
            class="border-0 bg-cyan-400 rounded-l-md"
          />
          <button
            id="copy-to-clipboard-hook"
            data-to="#control-codes-hook"
            phx-hook="CopyToClipboard"
            class="bg-rose-200 rounded-r-md w-full"
          >
            <span> 📋 </span>
          </button>
        </div>
      </div>

      <div class="flex flex-col items-center">
        <label class="text-white">Try me out here!</label>
        <input type="text" class="border-0 bg-cyan-400 rounded-md w-1/2" />
      </div>
    </div>
    """
  end
end
