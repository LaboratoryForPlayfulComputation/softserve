defmodule SoftserveTest do
  use ExUnit.Case
  doctest Softserve

  test "greets the world" do
    assert Softserve.hello() == :world
  end
end
