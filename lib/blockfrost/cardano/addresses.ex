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
    name
    |> HTTP.build_and_send(:get, "/addresses/#{address}", opts)
    |> Response.deserialize(SpecificAddressResponse)
  end

  @doc """
  """
  def address_details(name, address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/addresses/#{address}/total", opts)
    |> Response.deserialize(AddressDetailsResponse)
  end

  @doc """
  """
  def address_utxos(name, address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/addresses/#{address}/utxos",
      opts
    )
    |> Response.deserialize(AddressUTXOsResponse)
  end

  @doc """
  """
  def address_transactions(name, address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    opts =
      opts
      |> Utils.extract_pagination()
      |> Utils.extract_query_params([:to, :from])

    name
    |> HTTP.build_and_send(
      :get,
      "/addresses/#{address}/transactions",
      opts
    )
    |> Response.deserialize(AddressTransactionsResponse)
  end
end
