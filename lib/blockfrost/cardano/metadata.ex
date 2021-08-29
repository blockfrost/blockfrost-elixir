defmodule Blockfrost.Cardano.Metadata do
  @moduledoc """

  """
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
