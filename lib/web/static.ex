defmodule Web.Static do
    
    use Plug.Builder
  
    plug Plug.Static,
      at: "/hi",
      from: {:softserve, "lib/web/test"}
    
    plug :not_found
  
    def not_found(conn, _) do
      IO.puts("404: Not found")
      IO.puts inspect conn
      send_resp(conn, 404, "not found")
    end
  
end