defmodule Blockfrost.API.Metrics do
  @moduledoc """

  """
  alias Blockfrost.HTTP
  alias Blockfrost.Response

  alias Blockfrost.Response.{
    BlockfrostEndpointUsageMetricsResponse,
    BlockfrostUsageMetricsResponse
  }

  @doc """
  History of your Blockfrost usage metrics in the past 30 days
  """
  def blockfrost_usage_metrics(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/metrics", opts)
    |> Response.deserialize(BlockfrostUsageMetricsResponse)
  end

  @doc """
  History of your Blockfrost usage metrics per endpoint in the past 30 days
  """
  def blockfrost_endpoint_usage_metrics(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/metrics/endpoints", opts)
    |> Response.deserialize(BlockfrostEndpointUsageMetricsResponse)
  end
end
