defmodule Blockfrost.Cardano.Pools do
  @moduledoc "Functions for to the /pools namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Utils
  alias Blockfrost.Response

  alias Blockfrost.Response.{
    ListOfStakePoolsResponse,
    ListOfRetiredStakePoolsResponse,
    ListOfRetiringStakePoolsResponse,
    SpecificStakePoolResponse,
    StakePoolHistoryResponse,
    StakePoolMetadataResponse,
    StakePoolRelaysResponse,
    StakePoolDelegatorsResponse,
    StakePoolBlocksResponse,
    StakePoolUpdatesResponse
  }

  @doc """
  List of registered stake pools.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools/get)
  """
  @spec list_of_stake_pools(Blockfrost.t(), Keyword.t()) ::
          {:ok, ListOfStakePoolsResponse.t()} | HTTP.error_response()
  def list_of_stake_pools(name, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools", opts)
    |> Response.deserialize(ListOfStakePoolsResponse)
  end

  @doc """
  List of already retired pools

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1retired/get)
  """
  @spec list_of_retired_stake_pools(Blockfrost.t(), Keyword.t()) ::
          {:ok, ListOfRetiredStakePoolsResponse.t()} | HTTP.error_response()
  def list_of_retired_stake_pools(name, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/retired", opts)
    |> Response.deserialize(ListOfRetiredStakePoolsResponse)
  end

  @doc """
  List of stake pools retiring in the upcoming epochs

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1retiring/get)
  """
  @spec list_of_retiring_stake_pools(Blockfrost.t(), Keyword.t()) ::
          {:ok, ListOfRetiringStakePoolsResponse.t()} | HTTP.error_response()
  def list_of_retiring_stake_pools(name, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/retiring", opts)
    |> Response.deserialize(ListOfRetiringStakePoolsResponse)
  end

  @doc """
  Pool information

  [API Docs]()https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}/get
  """
  @spec specific_stake_pool(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificStakePoolResponse.t()} | HTTP.error_response()
  def specific_stake_pool(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}", opts)
    |> Response.deserialize(SpecificStakePoolResponse)
  end

  @doc """
  History of stake pool parameters over epochs

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}~1history/get)
  """
  @spec stake_pool_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, StakePoolHistoryResponse.t()} | HTTP.error_response()
  def stake_pool_history(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}/history", opts)
    |> Response.deserialize(StakePoolHistoryResponse)
  end

  @doc """
  Stake pool registration metadata

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}~1metadata/get)
  """
  @spec stake_pool_metadata(Blockfrost.t(), Keyword.t()) ::
          {:ok, StakePoolMetadataResponse.t()} | HTTP.error_response()
  def stake_pool_metadata(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}/metadata", opts)
    |> Response.deserialize(StakePoolMetadataResponse)
  end

  @doc """
  Relays of a stake pool

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}~1relays/get)
  """
  @spec stake_pool_relays(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, StakePoolRelaysResponse.t()} | HTTP.error_response()
  def stake_pool_relays(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}/relays", opts)
    |> Response.deserialize(StakePoolRelaysResponse)
  end

  @doc """
  List of current stake pools delegators

  Supports pagination.

  https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}~1delegators/get
  """
  @spec stake_pool_delegators(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, StakePoolDelegatorsResponse.t()} | HTTP.error_response()
  def stake_pool_delegators(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}/delegators", opts)
    |> Response.deserialize(StakePoolDelegatorsResponse)
  end

  @doc """
  List of stake pools blocks

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}~1blocks/get)
  """
  @spec stake_pool_blocks(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, StakePoolblocksResponse.t()} | HTTP.error_response()
  def stake_pool_blocks(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}/blocks", opts)
    |> Response.deserialize(StakePoolBlocksResponse)
  end

  @doc """
  List of certificate updates to the stake pool

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Pools/paths/~1pools~1{pool_id}~1updates/get)
  """
  @spec stake_pool_updates(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, StakePoolUpdatesResponse.t()} | HTTP.error_response()
  def stake_pool_updates(name, pool_id, opts \\ []) do
    Utils.validate_cardano!(name)

    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/pools/#{pool_id}/updates", opts)
    |> Response.deserialize(StakePoolUpdatesResponse)
  end
end
