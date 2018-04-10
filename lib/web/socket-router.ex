defmodule Softserve.SocketRouter do
    use Plug.Router
    
    plug :match
    plug :dispatch
    
    match _ do
      send_resp(conn, 200, "Hello from wsplug")
    end
  end
  