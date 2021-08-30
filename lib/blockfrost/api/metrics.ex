defmodule Blockfrost.API.Metrics do
  @moduledoc "Functions for to the /metrics namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response

  alias Blockfrost.Response.{
    BlockfrostEndpointUsageMetricsResponse,
    BlockfrostUsageMetricsResponse
  }

  @doc """
  History of your Blockfrost usage metrics in the past 30 days

  [API Docs](https://docs.blockfrost.io/#tag/Metrics/paths/~1metrics~1/get)
  """
  @spec blockfrost_usage_metrics(Blockfrost.t(), Keyword.t()) ::
          {:ok, BlockfrostUsageMetricsResponse.t()} | HTTP.error_response()
  def blockfrost_usage_metrics(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/metrics", opts)
    |> Response.deserialize(BlockfrostUsageMetricsResponse)
  end

  @doc """
  History of your Blockfrost usage metrics per endpoint in the past 30 days

  [API Docs](https://docs.blockfrost.io/#tag/Metrics/paths/~1metrics~1endpoints/get)
  """
  @spec blockfrost_endpoint_usage_metrics(Blockfrost.t(), Keyword.t()) ::
          {:ok, BlockfrostEndpointUsageMetricsResponse.t()} | HTTP.error_response()
  def blockfrost_endpoint_usage_metrics(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/metrics/endpoints", opts)
    |> Response.deserialize(BlockfrostEndpointUsageMetricsResponse)
  end
end
