defmodule Demonstration.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DemonstrationWeb.Telemetry,
      # Start the Ecto repository
      Demonstration.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Demonstration.PubSub},
      # Start Finch
      {Finch, name: Demonstration.Finch},
      # Start the Endpoint (http/https)
      DemonstrationWeb.Endpoint
      # Start a worker by calling: Demonstration.Worker.start_link(arg)
      # {Demonstration.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Demonstration.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemonstrationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
