defmodule Blockfrost.Cardano.Blocks do
  @moduledoc """

  """

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
  """
  def latest_block(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/latest", opts)
    |> Response.deserialize(LatestBlockResponse)
  end

  @doc """
  """
  def latest_block_transactions(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/latest/txs", opts)
    |> Response.deserialize(LatestBlockTransactionsResponse)
  end

  @doc """
  """
  def specific_block(name, hash_or_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}", opts)
    |> Response.deserialize(SpecificBlockResponse)
  end

  @doc """
  """
  def specific_block_in_slot(name, slot_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/blocks/slot/#{slot_number}", opts)
    |> Response.deserialize(SpecificBlockInSlotResponse)
  end

  @doc """
  """
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
  """
  def listing_of_next_blocks(name, hash_or_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}/next", opts)
    |> Response.deserialize(ListingOfNextBlocksResponse)
  end

  @doc """
  """
  def listing_of_previous_blocks(name, hash_or_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}/previous", opts)
    |> Response.deserialize(ListingOfPreviousBlocksResponse)
  end

  @doc """
  """
  def block_transactions(name, hash_or_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/blocks/#{hash_or_number}/txs", opts)
    |> Response.deserialize(BlockTransactionsResponse)
  end
end
