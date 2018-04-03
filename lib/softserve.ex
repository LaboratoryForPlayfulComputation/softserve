defmodule Softserve do
  @moduledoc """
  Documentation for Softserve.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Softserve.hello
      :world

  """
  def init(default_options) do
    IO.puts "init plug"
    default_options
  end

  def call(conn, options) do
    IO.puts "calling plug"

    conn
    |> Plug.Conn.send_resp(200, "hello world")
  end
  
end
