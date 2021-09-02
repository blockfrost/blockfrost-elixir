defmodule Blockfrost.Cardano.Ledger do
  @moduledoc "Functions for to the /ledger namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.BlockchainGenesisResponse
  alias Blockfrost.Utils

  @doc """
  Return the information about blockchain genesis.

  [API Doc](https://docs.blockfrost.io/#tag/Cardano-Ledger/paths/~1genesis/get)
  """
  @spec blockchain_genesis(Blockfrost.t(), Keyword.t()) :: BlockchainGenesisResponse.t()
  def blockchain_genesis(name, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/genesis", opts)
    |> Response.deserialize(BlockchainGenesisResponse)
  end
end
