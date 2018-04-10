defmodule Web.Router do
    use Plug.Router
    
    plug Plug.Logger
    plug :match
    plug Plug.Static,
      at: "/",
      from: {:softserve, "priv/message/"}
    plug :dispatch
  
    get "/" do
        conn
        |> put_resp_header("content-type", "text/html; charset=utf-8")
        |> send_file(200, "priv/message/index.html")
    end
    
    match _ do
      send_resp(conn, 404, "This is not the page you're looking for.")
    end
  
  end