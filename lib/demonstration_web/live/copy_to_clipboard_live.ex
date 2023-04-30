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
        <label class="text-white mb-2">JS Event Listener</label>
        <div class="w-1/2 rounded-md bg-white flex ">
          <input
            id="control-codes"
            type="text"
            value="12345#qwerty"
            class="border-0 bg-cyan-400 rounded-l-md border-b-4 border-cyan-600 hover:ring-4 ring-cyan-200 focus:ring-cyan-200 dark:shadow-md dark:shadow-cyan-800/80"
          />
          <button
            phx-click={JS.dispatch("phx:copy", to: "#control-codes")}
            class="bg-rose-200 rounded-r-md w-full hover:bg-rose-300 border-b-4 border-r-4 border-rose-400 hover:ring-4 ring-rose-200 focus:ring-rose-200 dark:shadow-md dark:shadow-pink-800/80"
          >
            <span> 📋 </span>
          </button>
        </div>
      </div>

      <div class="flex flex-col items-center">
        <label class="text-white mb-2">JS Hook</label>
        <div class="w-1/2 rounded-md bg-white flex">
          <input
            id="control-codes-hook"
            type="text"
            value="67890#asdfgh"
            class="border-0 bg-cyan-400 rounded-l-md border-b-4 border-cyan-600 hover:ring-4 ring-cyan-200 focus:ring-cyan-200 dark:shadow-md dark:shadow-cyan-800/80"
          />
          <button
            id="copy-to-clipboard-hook"
            data-to="#control-codes-hook"
            phx-hook="CopyToClipboard"
            class="bg-rose-200 rounded-r-md w-full hover:bg-rose-300 border-b-4 border-r-4 border-rose-400 hover:ring-4 ring-rose-200 focus:ring-rose-200 dark:shadow-md dark:shadow-pink-800/80"
          >
            <span> 📋 </span>
          </button>
        </div>
      </div>

      <div class="flex flex-col items-center">
        <label class="text-white mb-2">Try me out here!</label>
        <input
          type="text"
          class="border-0 bg-cyan-400 border-b-4 border-r-4 border-cyan-600 hover:ring-4 ring-cyan-200 focus:ring-cyan-200 rounded-md w-1/2 dark:shadow-md dark:shadow-cyan-800/80"
          placeholder="Paste from your clipboard right here"
        />
      </div>
    </div>
    """
  end
end
