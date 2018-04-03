defmodule Softserve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Softserve.Worker.start_link(arg)
      # {Softserve.Worker, arg},
      {Plug.Adapters.Cowboy, scheme: :http, plug: Web.Router, options: [port: 4000]}
    
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Softserve.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
