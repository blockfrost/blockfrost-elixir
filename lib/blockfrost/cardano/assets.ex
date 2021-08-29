defmodule Blockfrost.Cardano.Assets do
  @moduledoc """

  """

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
  """
  def assets(name, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets", pagination, %{}, nil, opts)
    |> Response.deserialize(AssetsResponse)
  end

  @doc """
  """
  def specific_asset(name, asset, opts \\ []) do
    req = HTTP.build(name, :get, "/assets/#{asset}")

    name
    |> HTTP.request(req, opts)
    |> Response.deserialize(SpecificAssetResponse)
  end

  @doc """
  """
  def asset_history(name, asset, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}/history", pagination, %{}, nil, opts)
    |> Response.deserialize(AssetHistoryResponse)
  end

  @doc """
  """
  def asset_transactions(name, asset, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}/transactions", pagination, %{}, nil, opts)
    |> Response.deserialize(AssetTransactionsResponse)
  end

  @doc """
  """
  def asset_addresses(name, asset, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/#{asset}/addresses", pagination, %{}, nil, opts)
    |> Response.deserialize(AssetAddressesResponse)
  end

  @doc """
  """
  def specific_policy_assets(name, policy_id, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/assets/policy/#{policy_id}", pagination, %{}, nil, opts)
    |> Response.deserialize(SpecificPolicyAssetsResponse)
  end
end
