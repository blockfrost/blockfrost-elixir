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

  def validate_ipfs!(name), do: validate_network!(name, [:ipfs])
  def validate_cardano!(name), do: validate_network!(name, [:cardano_mainnet, :cardano_testnet])

  def validate_network!(name, allowed_networks) do
    %{network: network} = Blockfrost.config(name)

    if network in allowed_networks do
      :ok
    else
      raise ArgumentError, """
      Blockfrost client #{name} is for network #{network}, but this function is only available for:
      #{inspect(allowed_networks)}
      """
    end
  end
end
