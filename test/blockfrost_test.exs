defmodule BlockfrostTest do
  use ExUnit.Case
  doctest Blockfrost

  describe "config/0,1" do
    test "returns config for a running Blockfrost supervisor" do
      start_supervised!({Blockfrost, default_opts()})

      assert %Blockfrost.Config{name: Blockfrost} = Blockfrost.config()

      start_supervised!({Blockfrost, default_opts(BlockfrostA)})

      assert %Blockfrost.Config{name: BlockfrostA} = Blockfrost.config(BlockfrostA)
    end
  end

  defp default_opts(name \\ Blockfrost) do
    [api_key: "token", network: :cardano_testnet, name: name]
  end
end
