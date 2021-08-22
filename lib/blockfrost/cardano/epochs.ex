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
  def latest_epoch(name \\ Blockfrost, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/latest", %{}, %{}, nil, opts)
    |> Response.deserialize(LatestEpochResponse)
  end

  @doc """
  """
  def latest_epoch_protocol_parameters(name \\ Blockfrost, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/latest/parameters", %{}, %{}, nil, opts)
    |> Response.deserialize(LatestEpochProtocolParametersResponse)
  end

  @doc """
  """
  def specific_epoch(name \\ Blockfrost, epoch_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}", %{}, %{}, nil, opts)
    |> Response.deserialize(SpecificEpochResponse)
  end

  @doc """
  """
  def listing_of_next_epochs(name \\ Blockfrost, epoch_number, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/next", pagination, %{}, nil, opts)
    |> Response.deserialize(ListingOfNextEpochsResponse)
  end

  @doc """
  """
  def listing_of_previous_epochs(name \\ Blockfrost, epoch_number, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/previous", pagination, %{}, nil, opts)
    |> Response.deserialize(ListingOfPreviousEpochsResponse)
  end

  @doc """
  """
  def stake_distribution(name \\ Blockfrost, epoch_number, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/stakes", pagination, %{}, nil, opts)
    |> Response.deserialize(StakeDistributionResponse)
  end

  @doc """
  """
  def stake_distribution_by_pool(name \\ Blockfrost, epoch_number, pool_id, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/epochs/#{epoch_number}/stakes/#{pool_id}",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(StakeDistributionByPoolResponse)
  end

  @doc """
  """
  def block_distribution(name \\ Blockfrost, epoch_number, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/blocks", pagination, %{}, nil, opts)
    |> Response.deserialize(BlockDistributionResponse)
  end

  @doc """
  """
  def block_distribution_by_pool(name \\ Blockfrost, epoch_number, pool_id, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/epochs/#{epoch_number}/blocks/#{pool_id}",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(BlockDistributionByPoolResponse)
  end

  @doc """
  """
  def protocol_parameters(name \\ Blockfrost, epoch_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/parameters", %{}, %{}, nil, opts)
    |> Response.deserialize(ProtocolParametersResponse)
  end
end
