defmodule Web.SocketHandler do 
  @behaviour :cowboy_websocket_handler
  require JSON

  def init(_, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  @timeout 60000 # terminate if no activity for one minute

  #Called on websocket connection initialization.
  def websocket_init(_type, req, _opts) do
    state = %{}
    {:ok, req, state, @timeout}
  end

  # Handle 'ping' messages from the browser - reply
  def websocket_handle({:text, "ping"}, req, state) do
    {:reply, {:text, "pong"}, req, state}
  end
  

  # Handle other messages from the browser 
  def websocket_handle({:text, message}, req, state) do
    #led catch experimentation
    {:ok, list} = JSON.decode(message)
    IO.puts(inspect list)

    case list["type"] do
      "LedOn" -> 
        IO.puts("Led on!")
        Blockytalky.GrovePi.set_component_value(:D2, 1)
      "Ledoff" -> 
        IO.puts("Led off!")
        Blockytalky.GrovePi.set_component_value(:D2, 0)
      _ -> 
        IO.puts("It's not an LED message so I don't care")
    end


    {:reply, {:text, message}, req, state}
  end

  # Format and forward elixir messages to client
  def websocket_info(message, req, state) do
    {:reply, {:text, message}, req, state}
  end

  # No matter why we terminate, remove all of this pids subscriptions
  def websocket_terminate(_reason, _req, _state) do
    :ok
  end
end
