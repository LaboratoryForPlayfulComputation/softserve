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

  # Handle other messages from the browser 
  def websocket_handle({:text, message}, req, state) do
    #led catch experimentation
    {:ok, list} = JSON.decode(message)

    case list["messageType"] do
      "setComponentType" -> 
        IO.puts("setComponentType recieved")
        Web.GrovePiMessage.set_component_type_message(list)
      "setComponentValue" -> 
        IO.puts("setComponentValue recieved")
        Web.GrovePiMessage.set_component_value_message(list)
      "getComponentValue" ->
        IO.puts("getComponentValue recieved")
        Web.GrovePiMessage.get_component_value_message(list)
      _ -> IO.puts("uncaught message type") 
    end
    {:reply, {:text, message}, req, state}
  end

  def websocket_handle({:text, "ping"}, req, state) do
    {:reply, {:text, "pong"}, req, state}
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
