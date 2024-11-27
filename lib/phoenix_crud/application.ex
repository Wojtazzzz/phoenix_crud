defmodule PhoenixCrud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixCrudWeb.Telemetry,
      PhoenixCrud.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_crud, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixCrud.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixCrud.Finch},
      # Start a worker by calling: PhoenixCrud.Worker.start_link(arg)
      # {PhoenixCrud.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixCrudWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixCrud.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixCrudWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
