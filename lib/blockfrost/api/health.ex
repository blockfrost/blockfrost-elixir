defmodule Blockfrost.API.Health do
  @moduledoc """

  """
  alias Blockfrost.HTTP
  alias Blockfrost.Response

  alias Blockfrost.Response.{
    RootResponse,
    BackendHealthStatusResponse,
    CurrentBackendTimeResponse
  }

  @doc """
  Has no other function than to point end users to documentation
  """
  def root(name, opts \\ []) do
    req = HTTP.build(name, :get, "/")

    name
    |> HTTP.request(req, opts)
    |> Response.deserialize(RootResponse)
  end

  @doc """
  Return backend status
  """
  def backend_health_status(name, opts \\ []) do
    req = HTTP.build(name, :get, "/health")

    name
    |> HTTP.request(req, opts)
    |> Response.deserialize(BackendHealthStatusResponse)
  end

  @doc """
  Provides the current UNIX time
  """
  def current_backend_time(name, opts \\ []) do
    req = HTTP.build(name, :get, "/health/clock")

    name
    |> HTTP.request(req, opts)
    |> Response.deserialize(CurrentBackendTimeResponse)
  end
end
