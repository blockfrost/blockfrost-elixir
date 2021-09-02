defmodule Blockfrost.Cardano.Addresses do
  @moduledoc "Functions for to the /addresses namespace in the Blockfrost API"

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
  Obtain information about a specific address

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Addresses/paths/~1addresses~1{address}/get)
  """
  @spec specific_address(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificAddressResponse.t()} | HTTP.error_response()
  def specific_address(name, address, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/addresses/#{address}", opts)
    |> Response.deserialize(SpecificAddressResponse)
  end

  @doc """
  Obtain details about a specific address

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Addresses/paths/~1addresses~1{address}~1total/get)
  """
  @spec address_details(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AddressDetailsResponse.t()} | HTTP.error_response()
  def address_details(name, address, opts \\ []) do
    Utils.validate_cardano!(name)
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/addresses/#{address}/total", opts)
    |> Response.deserialize(AddressDetailsResponse)
  end

  @doc """
  UTXOs of a specific address

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Addresses/paths/~1addresses~1{address}~1utxos/get)
  """
  @spec address_utxos(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AddressUTXOsResponse.t()} | HTTP.error_response()
  def address_utxos(name, address, opts \\ []) do
    Utils.validate_cardano!(name)
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
  Transactions of a specific address

  Supports pagination.

  Takes two additional options:
  - `:from`: The block number and optionally also index from which (inclusive) to start search
     for results, concatenated using colon. Has to be lower than or equal to to parameter.
     Example: `"8929261"`
  - `:to`: The block number and optionally also index where (inclusive) to end the search 
     for results, concatenated using colon. Has to be higher than or equal to from parameter. 
     Example: `"9999269:10"`

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Addresses/paths/~1addresses~1{address}~1transactions/get)
  """
  @spec address_transactions(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AddressTransactionsResponse.t()} | HTTP.error_response()
  def address_transactions(name, address, opts \\ []) do
    Utils.validate_cardano!(name)
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
