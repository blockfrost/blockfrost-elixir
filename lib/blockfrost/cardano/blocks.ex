defmodule Blockfrost.Cardano.Blocks do
  @moduledoc "Functions for to the /blocks namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    LatestBlockResponse,
    LatestBlockTransactionsResponse,
    SpecificBlockResponse,
    SpecificBlockInSlotResponse,
    SpecificBlockInSlotInEpochResponse,
    ListingOfNextBlocksResponse,
    ListingOfPreviousBlocksResponse,
    BlockTransactionsResponse
  }

  @doc """
  Return the latest block available to the backends, also known as the tip of the blockchain

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1latest/get)
  """
  @spec latest_block(Blockfrost.t(), Keyword.t()) ::
          {:ok, LatestBlockResponse.t()} | HTTP.error_response()
  def latest_block(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/latest", opts)
    |> Response.deserialize(LatestBlockResponse)
  end

  @doc """
  Return the transactions within the latest block.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1latest~1txs/get)
  """
  @spec latest_block_transactions(Blockfrost.t(), Keyword.t()) ::
          {:ok, LatestBlockTransactionsResponse.t()} | HTTP.error_response()
  def latest_block_transactions(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/latest/txs", opts)
    |> Response.deserialize(LatestBlockTransactionsResponse)
  end

  @doc """
  Return the content of a requested block.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1{hash_or_number}/get)
  """
  @spec specific_block(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificBlockResponse.t()} | HTTP.error_response()
  def specific_block(name, hash_or_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}", opts)
    |> Response.deserialize(SpecificBlockResponse)
  end

  @doc """
  Return the content of a requested block for a specific slot.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1slot~1{slot_number}/get)
  """
  @spec specific_block_in_slot(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificBlockInSlotResponse.t()} | HTTP.error_response()
  def specific_block_in_slot(name, slot_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/slot/#{slot_number}", opts)
    |> Response.deserialize(SpecificBlockInSlotResponse)
  end

  @doc """
  Return the content of a requested block for a specific slot in an epoch.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1epoch~1{epoch_number}~1slot~1{slot_number}/get)
  """
  @spec specific_block_in_slot_in_epoch(Blockfrost.t(), String.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificBlockInSlotInEpochResponse.t()} | HTTP.error_response()
  def specific_block_in_slot_in_epoch(name, epoch_number, slot_number, opts \\ []) do
    name
    |> HTTP.build_and_send(
      :get,
      "/blocks/epoch/#{epoch_number}/slot/#{slot_number}",
      opts
    )
    |> Response.deserialize(SpecificBlockInSlotInEpochResponse)
  end

  @doc """
  Return the list of blocks following a specific block.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1{hash_or_number}~1next/get)
  """
  @spec listing_of_next_blocks(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, ListingOfNextBlocksResponse.t()} | HTTP.error_response()
  def listing_of_next_blocks(name, hash_or_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}/next", opts)
    |> Response.deserialize(ListingOfNextBlocksResponse)
  end

  @doc """
  Return the list of blocks preceding a specific block.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1{hash_or_number}~1previous/get)
  """
  @spec listing_of_previous_blocks(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, ListingOfPreviousBlocksResponse.t()} | HTTP.error_response()
  def listing_of_previous_blocks(name, hash_or_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}/previous", opts)
    |> Response.deserialize(ListingOfPreviousBlocksResponse)
  end

  @doc """
  Return the transactions within the block.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Blocks/paths/~1blocks~1{hash_or_number}~1txs/get)
  """
  @spec block_transactions(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, BlockTransactionsResponse.t()} | HTTP.error_response()
  def block_transactions(name, hash_or_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}/txs", opts)
    |> Response.deserialize(BlockTransactionsResponse)
  end
end
