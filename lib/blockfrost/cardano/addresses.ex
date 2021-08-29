defmodule Blockfrost.Cardano.Addresses do
  @moduledoc """

  """
  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    SpecificAddressResponse,
    AddressDetailsResponse,
    AddressTransactionsResponse,
    AddressUTXOsResponse,
    AddressTransactionsResponse
  }

  @doc """
  """
  def specific_address(name, address, opts \\ []) do
    req = HTTP.build(name, :get, "/addresses/#{address}")

    name
    |> HTTP.request(req, opts)
    |> Response.deserialize(SpecificAddressResponse)
  end

  @doc """
  """
  def address_details(name, address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/addresses/#{address}/total", pagination, %{}, nil, opts)
    |> Response.deserialize(AddressDetailsResponse)
  end

  @doc """
  """
  def address_utxos(name, address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/addresses/#{address}/utxos",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(AddressUTXOsResponse)
  end

  @doc """
  """
  def address_transactions(name, address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/addresses/#{address}/transactions",
      pagination,
      Utils.to_query_params(opts, [:from, :to]),
      nil,
      opts
    )
    |> Response.deserialize(AddressTransactionsResponse)
  end
end
