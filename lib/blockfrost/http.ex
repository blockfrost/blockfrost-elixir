defmodule Blockfrost.HTTP do
  @moduledoc """
  HTTP requests to Blockfrost APIs.

  This module is not meant to be use directly. Use the higher level modules to do calls
  to the Blockfrost API.
  """

  @retryable_statuses [403, 429, 500]

  @doc """
  Builds a request and sends it.

  Supports pagination.

  If pagination.page is `:all`, will fetch all pages concurrently, with retries
  according to retry options.  If some page fails to be fetched, the first error
  found will be returned.

  Maximum concurrency can be configured by 

  Keeps data in the order requested.
  """
  def build_and_send(
        name,
        method,
        path,
        pagination \\ %{},
        query_params \\ %{},
        body \\ nil,
        opts \\ []
      ) do
    case pagination do
      %{page: :all} ->
        fetch_all_pages(name, method, path, query_params, body, opts)

      _ ->
        req = build(name, method, path, Map.merge(pagination, query_params), body)
        request(name, req, opts)
    end
  end

  defp fetch_all_pages(name, method, path, query_params, body, opts) do
    max_concurrency = opts[:max_concurrency] || 10

    fetch_page = fn page ->
      pagination = %{count: 100, page: page, order: "asc"}
      req = build(name, method, path, Map.merge(pagination, query_params), body)
      request(name, req, opts)
    end

    do_fetch_all_pages(name, 1..max_concurrency, fetch_page, max_concurrency)
    |> Enum.reduce_while([], fn {:ok, handled}, acc ->
      case handled do
        {:ok, response} ->
          {:cont, [response | acc]}

        err ->
          {:halt, err}
      end
    end)
    |> case do
      responses when is_list(responses) -> {:ok, Enum.reverse(responses)}
      err -> err
    end
  end

  # will stop earlier if some error is not solved by retries
  defp do_fetch_all_pages(
         name,
         %Range{first: first, last: last} = range,
         fetch_page,
         max_concurrency,
         acc \\ []
       ) do
    responses =
      name
      |> Module.concat(TaskSupervisor)
      |> Task.Supervisor.async_stream(range, fetch_page,
        max_concurrency: max_concurrency,
        ordered: true
      )
      |> Enum.to_list()

    next_range = %Range{range | first: last + 1, last: last + (1 + last - first)}

    if should_fetch_more?(responses),
      do: do_fetch_all_pages(name, next_range, fetch_page, max_concurrency, acc ++ responses),
      else: acc ++ responses
  end

  defp should_fetch_more?(responses) do
    expected_count = Enum.count(responses) * 100

    result_count =
      responses
      |> Enum.map(&elem(&1, 1))
      |> Enum.map(fn
        {:ok, response} ->
          Jason.decode!(response.body)

        _e ->
          []
      end)
      |> List.flatten()
      |> Enum.count()

    expected_count == result_count
  end

  @doc """
  Builds a request to a Blockfrost API

  This function only builds the request. You can execute it with `request/3`.
  """
  @spec build(atom, Finch.Request.method(), binary, map, binary) :: Finch.Request.t()
  def build(name, method, path, query_params \\ %{}, opts \\ []) do
    config = Blockfrost.config(name)
    path = resolve_path(config, path, query_params)
    headers = resolve_headers(config, opts)

    Finch.build(method, path, headers, opts[:body])
  end

  defp resolve_path(%Blockfrost.Config{network_uri: base_uri}, path, query_params) do
    query = URI.encode_query(query_params)

    %{base_uri | path: base_uri.path <> path, query: query}
  end

  defp resolve_headers(%Blockfrost.Config{api_key: api_key}, opts) do
    {:ok, version} = :application.get_key(:blockfrost, :vsn)

    content_type = opts[:content_type] || "application/json"

    content_length =
      if length = opts[:content_length],
        do: [{"Content-Length", inspect(length)}],
        else: []

    [
      {"project_id", api_key},
      {"User-Agent", "blockfrost-elixir/#{version}"},
      {"Content-Type", content_type}
    ] ++ content_length
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
  def request(name, request, opts \\ []) do
    finch = Module.concat(name, Finch)
    config = Blockfrost.config(name)
    client = Application.get_env(:blockfrost, :__http_client__, Finch)

    fn ->
      client.request(request, finch, opts)
    end
    |> with_retry(opts, config)
    |> handle_response(opts)
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

  defp handle_response({:ok, response}, opts) do
    if opts[:skip_error_handling?] do
      {:ok, response}
    else
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
  end

  defp handle_response(err, _opts), do: err
end
