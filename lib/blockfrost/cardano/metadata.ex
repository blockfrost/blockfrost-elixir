defmodule Blockfrost.Cardano.Metadata do
  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    TransactionMetadataLabelsResponse,
    TransactionMetadataContentJSONResponse,
    TransactionMetadataContentCBORResponse
  }

  @doc """
  List of all used transaction metadata labels.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Metadata/paths/~1metadata~1txs~1labels/get)
  """
  @spec transaction_metadata_labels(Blockfrost.t(), Keyword.t()) ::
          {:ok, TransactionMetadataLabelsResponse.t()} | HTTP.error_response()
  def transaction_metadata_labels(name, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/metadata/txs/labels",
      opts
    )
    |> Response.deserialize(TransactionMetadataLabelsResponse)
  end

  @doc """
  Transaction metadata per label.

  The json data is automatically parsed.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Metadata/paths/~1metadata~1txs~1labels~1{label}/get)
  """
  @spec transaction_metadata_content_json(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, TransactionMetadataContentJSONResponse.t()} | HTTP.error_response()
  def transaction_metadata_content_json(name, label, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/metadata/txs/labels/#{label}",
      opts
    )
    |> Response.deserialize(TransactionMetadataContentJSONResponse)
  end

  @doc """
  Transaction metadata per label.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Metadata/paths/~1metadata~1txs~1labels~1{label}~1cbor/get)
  """
  @spec transaction_metadata_content_cbor(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, TransactionMetadataContentCBORResponse.t()} | HTTP.error_response()
  def transaction_metadata_content_cbor(name, label, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/metadata/txs/labels/#{label}/cbor",
      opts
    )
    |> Response.deserialize(TransactionMetadataContentCBORResponse)
  end
end
