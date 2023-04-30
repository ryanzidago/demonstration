defmodule DemonstrationWeb.CopyToClipboardLive do
  @doc """
  https://fly.io/phoenix-files/copy-to-clipboard-with-phoenix-liveview/
  """
  use DemonstrationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col space-y-8">
      <div class="flex flex-col items-center">
        <p class="text-white">Event Listener</p>
        <button
          phx-click={JS.dispatch("phx:copy", to: "#control-codes")}
          class="bg-rose-200 border-0 rounded-md w-1/2 flex flex-row items-center"
        >
          <input
            type="text"
            id="control-codes"
            value="12345#qwerty"
            class="border-0 rounded-l-md bg-cyan-400"
          />
          <span class="w-full"> 📋 </span>
        </button>
      </div>

      <div class="flex flex-col items-center">
        <p class="text-white">Client Hook</p>
        <button
          id="copy-to-clipboard"
          data-to="#control-codes-hook"
          phx-hook="CopyToClipboard"
          class="bg-rose-200 border-0 rounded-md w-1/2 flex flex-row items-center"
        >
          <input
            type="text"
            id="control-codes-hook"
            value="67890#asdfgh"
            class="border-0 rounded-l-md bg-cyan-400"
          />
          <span class="w-full"> 📋 </span>
        </button>
      </div>

      <div class="flex flex-col items-center">
        <p class="text-white">Try me out here!</p>
        <input type="text" class="border-0 bg-cyan-400 rounded-md w-1/2" />
      </div>
    </div>
    """
  end
end
