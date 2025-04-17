defmodule GitsElixirPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GitsElixirPhoenixWeb.Telemetry,
      GitsElixirPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:gits_elixir_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GitsElixirPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GitsElixirPhoenix.Finch},
      # Start a worker by calling: GitsElixirPhoenix.Worker.start_link(arg)
      # {GitsElixirPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      GitsElixirPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GitsElixirPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GitsElixirPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
