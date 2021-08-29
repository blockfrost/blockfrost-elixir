defmodule Blockfrost.Cardano.Ledger do
  @moduledoc """

  """

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.BlockchainGenesisResponse

  @doc """
  """
  def blockchain_genesis(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/genesis", opts)
    |> Response.deserialize(BlockchainGenesisResponse)
  end
end
