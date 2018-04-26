defmodule Web.GrovePiMessage do
    @moduledoc """
  handles JSON websocket messages to and from makecode (pxt) instance
  """

  def led(message) do
      case message["message"] do
          "configure" -> 
            IO.puts("led configure")
            ledconfigure
          "on" -> 
            IO.puts("turn led on")
          "off" -> 
            IO.puts("turn led off")
          _-> 
            IO.puts("unhandled led message!")
      end
  end

  defp ledconfigure()
end