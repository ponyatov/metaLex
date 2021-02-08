defmodule MetalTest do
  use ExUnit.Case
  doctest MetaL

  test "run" do
    assert MetaL.run() == :ok
  end
end
