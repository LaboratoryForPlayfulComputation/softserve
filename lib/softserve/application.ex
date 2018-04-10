defmodule Softserve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Plug.Adapters.Cowboy, scheme: :http, plug: Web.Router, options: [port: 8000]},
      Plug.Adapters.Cowboy.child_spec(:http, Web.SocketRouter, [], [
        dispatch: dispatch
      ])
      
    ]    
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Softserve.Supervisor]
    Supervisor.start_link(children, opts)

  end

  defp dispatch do
    [
      {:_, [
        {"/ws", Web.SocketHandler, []},
        {:_, Plug.Adapters.Cowboy.Handler, {Web.SocketRouter, []}}
      ]}
    ]
  end

end


'''
{Plug.Adapters.Cowboy, scheme: :http, plug: Web.Router, options: [port: 8080]},
'''