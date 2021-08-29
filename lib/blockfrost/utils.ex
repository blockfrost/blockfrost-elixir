defmodule Blockfrost.Utils do
  @moduledoc false

  @spec extract_pagination(Keyword.t()) :: map
  def extract_pagination(opts) do
    pagination =
      opts
      |> Keyword.take([:page, :count, :order])
      |> Map.new()

    Keyword.put(opts, :pagination, pagination)
  end

  def extract_query_params(opts, keys) do
    query_params =
      opts
      |> Keyword.take(keys)
      |> Map.new()

    Keyword.put(opts, :query_params, query_params)
  end
end
