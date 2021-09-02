defmodule Blockfrost.UtilsTest do
  use Blockfrost.Case

  alias Blockfrost.Utils

  describe "validate_network!/2" do
    test "returns :ok if instance is valid for networks" do
      start_supervised!({Blockfrost, name: TestNet, api_key: "apikey", network: :cardano_testnet})

      Utils.validate_network!(TestNet, [:cardano_testnet])
    end

    test "raises argument error if instance is invalid for networks" do
      start_supervised!({Blockfrost, name: TestNet, api_key: "apikey", network: :cardano_testnet})

      assert_raise(ArgumentError, fn ->
        Utils.validate_network!(TestNet, [:ipfs])
      end)
    end

    test "raises if blockfrost client doesn't exist" do
      assert_raise(ArgumentError, fn ->
        Utils.validate_network!(TestNet, [:ipfs])
      end)
    end
  end
end
