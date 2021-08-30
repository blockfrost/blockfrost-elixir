defmodule Blockfrost.API.Health do
  @moduledoc """
  Information about health of API
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

  [API docs](https://docs.blockfrost.io/#tag/Health/paths/~1/get)
  """
  @spec root(Blockfrost.t(), Keyword.t()) :: {:ok, RootResponse.t()} | HTTP.error_response()
  def root(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/", opts)
    |> Response.deserialize(RootResponse)
  end

  @doc """
  Return backend status

  [API docs](https://docs.blockfrost.io/#tag/Health/paths/~1/get)
  """
  @spec backend_health_status(Blockfrost.t(), Keyword.t()) ::
          {:ok, BackendHealthStatusResponse.t()} | HTTP.error_response()
  def backend_health_status(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/health", opts)
    |> Response.deserialize(BackendHealthStatusResponse)
  end

  @doc """
  Provides the current UNIX time

  [API docs](https://docs.blockfrost.io/#tag/Health/paths/~1health~1clock/get)
  """
  @spec current_backend_time(Blockfrost.t(), Keyword.t()) ::
          {:ok, CurrentBackendTimeResponse.t()} | HTTP.error_response()
  def current_backend_time(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/health/clock", opts)
    |> Response.deserialize(CurrentBackendTimeResponse)
  end
end
