defmodule Blockfrost.Cardano.Ledger do
  @moduledoc """

  """

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.BlockchainGenesisResponse

  @doc """
  """
  def blockchain_genesis(name \\ Blockfrost, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/genesis", %{}, %{}, nil, opts)
    |> Response.deserialize(BlockchainGenesisResponse)
  end
end
