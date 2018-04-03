defmodule Web.Newstatic do
    use Plug.Builder
    plug Plug.Logger
    plug Plug.Static, at: "/", from: "/lib/web/test"    
end

