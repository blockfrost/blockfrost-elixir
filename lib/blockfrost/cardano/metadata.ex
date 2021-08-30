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
