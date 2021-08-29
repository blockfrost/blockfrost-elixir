defmodule Blockfrost.Config do
  @moduledoc false

  use GenServer

  defstruct [
    :name,
    :api_key,
    :network,
    :network_uri,
    :retry_enabled?,
    :retry_max_attempts,
    :retry_interval
  ]

  @type t :: %__MODULE__{}

  @networks %{
    cardano_mainnet: URI.parse("https://cardano-mainnet.blockfrost.io/api/v0"),
    cardano_testnet: URI.parse("https://cardano-testnet.blockfrost.io/api/v0"),
    ipfs: URI.parse("https://ipfs.blockfrost.io/api/v0")
  }

  @valid_networks Map.keys(@networks)

  @doc """
  Validates options and turns them into a %Blockfrost.Config{} struct
  """
  @spec validate!(Keyword.t()) :: t
  def validate!(opts) do
    api_key = opts[:api_key] || raise ":api_key is required!"
    network = opts[:network] || raise ":network is required!"

    unless network in @valid_networks,
      do: raise("Invalid network, expected one of #{inspect(@valid_networks)}")

    struct!(__MODULE__, %{
      name: opts[:name] || Blockfrost,
      api_key: api_key,
      network: network,
      network_uri: @networks[network],
      retry_enabled?: Keyword.get(opts, :retry_enabled?, true),
      retry_max_attempts: opts[:retry_max_attempts] || 5,
      retry_interval: opts[:retry_interval] || 2
    })
  end

  @doc """
  Returns config for a running instance
  """
  @spec read(atom()) :: t
  def read(name) do
    name
    |> Module.concat(ConfigTable)
    |> :ets.lookup(:config)
    |> List.first()
    |> elem(1)
  end

  @impl true
  def init(config) do
    table_name = Module.concat(config.name, ConfigTable)

    :ets.new(table_name, [:named_table, :public, read_concurrency: true])
    :ets.insert(table_name, {:config, config})

    {:ok, nil}
  end

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts)
end
