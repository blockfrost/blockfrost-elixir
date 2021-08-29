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
    name
    |> HTTP.build_and_send(:get, "/", opts)
    |> Response.deserialize(RootResponse)
  end

  @doc """
  Return backend status
  """
  def backend_health_status(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/health", opts)
    |> Response.deserialize(BackendHealthStatusResponse)
  end

  @doc """
  Provides the current UNIX time
  """
  def current_backend_time(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/health/clock", opts)
    |> Response.deserialize(CurrentBackendTimeResponse)
  end
end
