defmodule BlockfrostTest do
  use ExUnit.Case
  doctest Blockfrost

  test "greets the world" do
    assert Blockfrost.hello() == :world
  end
end
