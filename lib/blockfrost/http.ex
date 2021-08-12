defmodule Blockfrost.HTTP do
  @moduledoc """
  HTTP requests to Blockfrost APIs.

  This module is not meant to be use directly. Use the higher level modules to do calls
  to the Blockfrost API.
  """

  @retryable_statuses [403, 429, 500]

  @doc """
  Builds a request to a Blockfrost API

  This function only builds the request. You can execute it with `request/3`.
  """
  @spec build(atom, Finch.Request.method(), binary(), binary()) :: Finch.Request.t()
  def build(name \\ Blockfrost, method, path, body \\ nil) do
    config = Blockfrost.config(name)
    path = resolve_path(config, path)
    headers = resolve_headers(config)

    Finch.build(method, path, headers, body)
  end

  defp resolve_path(%Blockfrost.Config{network_uri: base_uri}, path) do
    %{base_uri | path: base_uri.path <> path}
  end

  defp resolve_headers(%Blockfrost.Config{api_key: api_key}) do
    [{"project_id", api_key}]
  end

  @doc """
  Does a request to a Blockfrost API.

  Receives the following options:
  - `:retry_enabled?`: whether it should retry failing requests
  - `:retry_max_attempts`: max retry attempts
  - `:retry_interval`: interval between attempts

  All these options fall back to the config. If they're not defined there,
  they fall back to default values. See `Blockfrost.Config` for more info.

  For additional options, see `c:Finch.request/3`

  Build requests with `build/4`.
  """
  @spec request(atom, Finch.Request.t(), Keyword.t()) :: Finch.Response.t()
  def request(name \\ Blockfrost, request, opts \\ []) do
    finch = Module.concat(name, Finch)
    config = Blockfrost.config(name)
    client = Application.get_env(:blockfrost, :__http_client__, Finch)

    fn ->
      client.request(request, finch, opts)
    end
    |> with_retry(opts, config)
    |> handle_response()
  end

  defp with_retry(fun, opts, config, attempt \\ 1) do
    enabled? = opts[:retry_enabled?] || config.retry_enabled?
    max_attempts = opts[:retry_max_attempts] || config.retry_max_attempts
    interval = opts[:retry_interval] || config.retry_interval

    if enabled? and attempt < max_attempts do
      case fun.() do
        {:ok, %{status: status}} when status in @retryable_statuses ->
          :timer.sleep(interval)
          with_retry(fun, opts, config, attempt + 1)

        {:ok, response} ->
          {:ok, response}

        {:error, _} ->
          :timer.sleep(interval)
          with_retry(fun, opts, config, attempt + 1)
      end
    else
      fun.()
    end
  end

  defp handle_response({:ok, response}) do
    case response do
      %{status: status} when status in 199..399 ->
        {:ok, response}

      %{status: 400} ->
        {:error, :bad_request}

      %{status: 403} ->
        {:error, :unauthenticated}

      %{status: 418} ->
        {:error, :ip_banned}

      %{status: 429} ->
        {:error, :usage_limit_reached}

      %{status: 500} ->
        {:error, :internal_server_error}
    end
  end

  defp handle_response(err), do: err
end
