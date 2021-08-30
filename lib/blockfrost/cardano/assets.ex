defmodule Blockfrost.Cardano.Assets do
  @moduledoc "Functions for to the /assets namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    AssetsResponse,
    SpecificAssetResponse,
    AssetHistoryResponse,
    AssetTransactionsResponse,
    AssetAddressesResponse,
    SpecificPolicyAssetsResponse
  }

  @doc """
  Lists of assets

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Assets/paths/~1assets/get)
  """
  @spec assets(Blockfrost.t(), Keyword.t()) :: {:ok, AssetsResponse.t()} | HTTP.error_response()
  def assets(name, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets", opts)
    |> Response.deserialize(AssetsResponse)
  end

  @doc """
  Information about a specific asset

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Assets/paths/~1assets~1{asset}/get)
  """
  @spec specific_asset(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificAssetResponse.t()} | HTTP.error_response()
  def specific_asset(name, asset, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}", opts)
    |> Response.deserialize(SpecificAssetResponse)
  end

  @doc """
  History of a specific asset

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Assets/paths/~1assets~1{asset}~1history/get)
  """
  @spec asset_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AssetHistoryResponse.t()} | HTTP.error_response()
  def asset_history(name, asset, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}/history", opts)
    |> Response.deserialize(AssetHistoryResponse)
  end

  @doc """
  List of a specific asset transactions

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Assets/paths/~1assets~1{asset}~1transactions/get)
  """
  @spec asset_transactions(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AssetTransactionsResponse.t()} | HTTP.error_response()
  def asset_transactions(name, asset, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}/transactions", opts)
    |> Response.deserialize(AssetTransactionsResponse)
  end

  @doc """
  List of a addresses containing a specific asset

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Assets/paths/~1assets~1{asset}~1addresses/get)
  """
  @spec asset_addresses(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AssetAddressesResponse.t()} | HTTP.error_response()
  def asset_addresses(name, asset, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}/addresses", opts)
    |> Response.deserialize(AssetAddressesResponse)
  end

  @doc """
  List of asset minted under a specific policy

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Assets/paths/~1assets~1policy~1{policy_id}/get)
  """
  @spec specific_policy_assets(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificPolicyAssetsResponse.t()} | HTTP.error_response()
  def specific_policy_assets(name, policy_id, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/policy/#{policy_id}", opts)
    |> Response.deserialize(SpecificPolicyAssetsResponse)
  end
end
