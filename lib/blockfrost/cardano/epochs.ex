defmodule Blockfrost.Cardano.Epochs do
  @moduledoc """

  """

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    LatestEpochResponse,
    LatestEpochProtocolParametersResponse,
    SpecificEpochResponse,
    ListingOfNextEpochsResponse,
    ListingOfPreviousEpochsResponse,
    StakeDistributionResponse,
    StakeDistributionByPoolResponse,
    BlockDistributionResponse,
    BlockDistributionByPoolResponse,
    ProtocolParametersResponse
  }

  @doc """
  """
  def latest_epoch(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/latest", opts)
    |> Response.deserialize(LatestEpochResponse)
  end

  @doc """
  """
  def latest_epoch_protocol_parameters(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/latest/parameters", opts)
    |> Response.deserialize(LatestEpochProtocolParametersResponse)
  end

  @doc """
  """
  def specific_epoch(name, epoch_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}", opts)
    |> Response.deserialize(SpecificEpochResponse)
  end

  @doc """
  """
  def listing_of_next_epochs(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/next", opts)
    |> Response.deserialize(ListingOfNextEpochsResponse)
  end

  @doc """
  """
  def listing_of_previous_epochs(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/previous", opts)
    |> Response.deserialize(ListingOfPreviousEpochsResponse)
  end

  @doc """
  """
  def stake_distribution(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/stakes", opts)
    |> Response.deserialize(StakeDistributionResponse)
  end

  @doc """
  """
  def stake_distribution_by_pool(name, epoch_number, pool_id, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/epochs/#{epoch_number}/stakes/#{pool_id}",
      opts
    )
    |> Response.deserialize(StakeDistributionByPoolResponse)
  end

  @doc """
  """
  def block_distribution(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/blocks", opts)
    |> Response.deserialize(BlockDistributionResponse)
  end

  @doc """
  """
  def block_distribution_by_pool(name, epoch_number, pool_id, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/epochs/#{epoch_number}/blocks/#{pool_id}",
      opts
    )
    |> Response.deserialize(BlockDistributionByPoolResponse)
  end

  @doc """
  """
  def protocol_parameters(name, epoch_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/parameters", opts)
    |> Response.deserialize(ProtocolParametersResponse)
  end
end
