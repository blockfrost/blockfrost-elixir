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
  def transaction_metadata_labels(name \\ Blockfrost, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/metadata/txs/labels",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(TransactionMetadataLabelsResponse)
  end

  def transaction_metadata_content_json(name \\ Blockfrost, label, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/metadata/txs/labels/#{label}",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(TransactionMetadataContentJSONResponse)
  end

  def transaction_metadata_content_cbor(name \\ Blockfrost, label, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/metadata/txs/labels/#{label}/cbor",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(TransactionMetadataContentCBORResponse)
  end
end
