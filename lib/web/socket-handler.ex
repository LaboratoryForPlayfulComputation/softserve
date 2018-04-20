defmodule Web.SocketHandler do 
  @behaviour :cowboy_websocket_handler

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
<<<<<<< HEAD
    IO.puts('pong!')
=======
>>>>>>> master
    {:reply, {:text, "pong"}, req, state}
  end
  
  # Handle other messages from the browser - don't reply
  def websocket_handle({:text, message}, req, state) do
    IO.puts(message)
<<<<<<< HEAD
    {:ok, req, state}
=======
    {:reply, {:text, message}, req, state}
>>>>>>> master
  end

  # Format and forward elixir messages to client
  def websocket_info(message, req, state) do
    {:reply, {:text, message}, req, state}
  end

  # No matter why we terminate, remove all of this pids subscriptions
  def websocket_terminate(_reason, _req, _state) do
    :ok
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> master
