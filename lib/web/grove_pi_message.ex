defmodule Web.GrovePiMessage do
    @moduledoc """
  handles JSON websocket messages to and from makecode (pxt) instance
  """

  
  def set_component_type_message(list) do
    IO.puts("message module got set type")
  end

  def set_component_value_message(list) do
    IO.puts("message module got set value")
  end

  def get_component_value_message(list) do
    IO.puts("message module got get value")
  end

end