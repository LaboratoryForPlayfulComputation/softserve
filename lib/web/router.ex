defmodule Web.Router do
    use Plug.Router
    
<<<<<<< HEAD
    plug Plug.Logger, log: :debug
    plug :match
    plug Plug.Static,
      at: "/",
      from: {:softserve, "priv/static"}
=======
    plug Plug.Logger
    plug :match
    plug Plug.Static,
      at: "/",
      from: {:softserve, "priv/message/"}
>>>>>>> master
    plug :dispatch
  
    get "/" do
        conn
        |> put_resp_header("content-type", "text/html; charset=utf-8")
<<<<<<< HEAD
        |> send_file(200, "priv/static/index.html")
=======
        |> send_file(200, "priv/message/index.html")
>>>>>>> master
    end
    
    match _ do
      send_resp(conn, 404, "This is not the page you're looking for.")
    end
  
  end