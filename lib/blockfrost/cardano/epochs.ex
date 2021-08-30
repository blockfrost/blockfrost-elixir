defmodule Blockfrost.Cardano.Epochs do
  @moduledoc "Functions for to the /epochs namespace in the Blockfrost API"

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
  Return the information about the latest, therefore current, epoch

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1latest/get)
  """
  @spec latest_epoch(Blockfrost.t(), Keyword.t()) ::
          {:ok, LatestEpochResponse.t()} | HTTP.error_response()
  def latest_epoch(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/latest", opts)
    |> Response.deserialize(LatestEpochResponse)
  end

  @doc """
  Return the protocol parameters for the latest epoch

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1latest~1parameters/get)
  """
  @spec latest_epoch_protocol_parameters(Blockfrost.t(), Keyword.t()) ::
          {:ok, LatestEpochProtocolParametersResponse.t()} | HTTP.error_response()
  def latest_epoch_protocol_parameters(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/latest/parameters", opts)
    |> Response.deserialize(LatestEpochProtocolParametersResponse)
  end

  @doc """
  Return the content of the requested epoch

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}/get)
  """
  @spec specific_epoch(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificEpochResponse.t()} | HTTP.error_response()
  def specific_epoch(name, epoch_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}", opts)
    |> Response.deserialize(SpecificEpochResponse)
  end

  @doc """
  Return the list of epochs following a specific epoch.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1next/get)
  """
  @spec listing_of_next_epochs(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, ListingOfNextEpochsResponse.t()} | HTTP.error_response()
  def listing_of_next_epochs(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/next", opts)
    |> Response.deserialize(ListingOfNextEpochsResponse)
  end

  @doc """
  Return the list of epochs preceding a specific epoch.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1previous/get)
  """
  @spec listing_of_previous_epochs(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, ListingOfPreviousEpochsResponse.t()} | HTTP.error_response()
  def listing_of_previous_epochs(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/previous", opts)
    |> Response.deserialize(ListingOfPreviousEpochsResponse)
  end

  @doc """
  Return the active stake distribution for the specified epoch.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1stakes/get)
  """
  @spec stake_distribution(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, StakeDistributionResponse.t()} | HTTP.error_response()
  def stake_distribution(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/stakes", opts)
    |> Response.deserialize(StakeDistributionResponse)
  end

  @doc """
  Return the active stake distribution for the epoch specified by stake pool.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1stakes~1{pool_id}/get)
  """
  @spec stake_distribution_by_pool(Blockfrost.t(), String.t(), String.t(), Keyword.t()) ::
          {:ok, StakeDistributionByPoolResponse.t()} | HTTP.error_response()
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
  Return the blocks minted for the epoch specified.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1blocks/get)
  """
  @spec block_distribution(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, BlockDistributionResponse.t()} | HTTP.error_response()
  def block_distribution(name, epoch_number, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/blocks", opts)
    |> Response.deserialize(BlockDistributionResponse)
  end

  @doc """
  Return the block minted for the epoch specified by stake pool.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1blocks~1{pool_id}/get)
  """
  @spec block_distribution_by_pool(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, BlockDistributionByPoolResponse.t()} | HTTP.error_response()
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
  Return the protocol parameters for the epoch specified.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Epochs/paths/~1epochs~1{number}~1parameters/get)
  """
  @spec protocol_parameters(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, ProtocolParametersResponse.t()} | HTTP.error_response()
  def protocol_parameters(name, epoch_number, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/epochs/#{epoch_number}/parameters", opts)
    |> Response.deserialize(ProtocolParametersResponse)
  end
end
