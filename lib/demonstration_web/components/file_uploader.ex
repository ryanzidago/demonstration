defmodule DemonstrationWeb.Components.FileUploader do
  @moduledoc """
  https://fly.io/phoenix-files/phoenix-liveview-zipped-uploads/
  https://hexdocs.pm/phoenix_live_view/uploads.html#built-in-features
  """
  use DemonstrationWeb, :live_component

  alias DemonstrationWeb.Components.Icons

  @impl true
  def mount(socket) do
    socket =
      socket
      |> assign(uploaded_files: [])
      |> allow_upload(:file,
        accept: ~w(.jpg .jpeg .pdf .txt),
        max_entries: 5,
        auto_upload: true,
        progress: &handle_progress/3
      )

    {:ok, socket}
  end

  @impl true
  def update(_assigns, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class=" bg-slate-400 rounded-sm w-full p-20 flex flex-col items-center">
      <form id="file-uploader-form" phx-submit="save" phx-change="validate" phx-target={@myself}>
        <label
          class="bg-slate-700 rounded-md flex flex-col items-center p-8 text-center cursor-pointer"
          phx-drop-target={@uploads.file.ref}
        >
          <div class="flex flex-col gap-2 items-center">
            <Icons.UploadFile.render class="w-6 h-6 text-slate-300" />
            <div class="text-slate-300">
              Drag and drop to upload <br /> or <span class="text-sky-400">browse</span>
              to choose a file
            </div>
          </div>
          <.live_file_input upload={@uploads.file} class="hidden" />
        </label>
      </form>

      <section>
        <article :for={entry <- @uploads.file.entries}>
          <figure>
            <%!-- <.live_img_preview entry={entry} /> --%>
            <figcaption><%= entry.client_name %></figcaption>
          </figure>

          <progress value={entry.progress} max="100"><%= entry.progress %></progress>

          <button
            type="button"
            phx-click="cancel_upload"
            phx-target={@myself}
            phx-value-ref={entry.ref}
            aria-label="cancel"
          >
            &times;
          </button>

          <p :for={error <- upload_errors(@uploads.file, entry)} class="alert alert-danger">
            <%= error_to_string(error) %>
          </p>
        </article>
      </section>
    </div>
    """
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("cancel_upload", %{"ref" => ref}, socket) do
    socket = cancel_upload(socket, :file, ref)
    {:noreply, socket}
  end

  defp handle_progress(:file, %{done?: true} = _entry, socket) do
    socket =
      case uploaded_entries(socket, :file) do
        {[_ | _] = _completed, [] = _in_progress} ->
          uploaded_files =
            consume_uploaded_entries(socket, :file, fn %{path: path}, entry ->
              file_name = build_file_name(entry.client_name)
              dest = Path.join("priv/static/uploads", file_name)

              File.cp!(path, dest)
              {:ok, ~p"/uploads/#{file_name}"}
            end)

          update(socket, :uploaded_files, &(&1 ++ uploaded_files))

        {_completed, _in_progress} ->
          socket
      end

    {:noreply, socket}
  end

  defp handle_progress(:file, %{done?: false} = _entry, socket) do
    {:noreply, socket}
  end

  defp build_file_name(file_name) do
    String.replace(file_name, " ", "_")
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
