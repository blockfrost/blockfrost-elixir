defmodule Blockfrost do
  @external_resource readme = Path.join([__DIR__, "../README.md"])

  @moduledoc readme
             |> File.read!()
             |> String.split("<!-- MDOC -->")
             |> Enum.fetch!(1)

  use Supervisor

  alias Blockfrost.Config

  @typedoc """
  The name of a Blockfrost instance
  """
  @type t :: atom()

  @doc """
  Starts a Blockfrost supervision tree.

  **Required options:**

  * `:name` - the name of the Blockfrost client. Defaults to `Blockfrost`
  * `:network` - the network for this client. Either `:cardano_mainnet`, `:cardano_testnet`, `:cardano_preview` or `:ipfs`
  * `:api_key` - Your Blockfrost API key

  **Other options:**

  * `:retry_enabled?` - whether it should retry failing requests. Defaults to `true`
  * `:retry_max_attempts` - max retry attempts. Defaults to `5`.
  * `:retry_interval` - interval between attempts, in milliseconds. Defaults to `500`.
  """
  @spec start_link(Keyword.t()) :: Supervisor.on_start()
  def start_link(opts) do
    config = Config.validate!(opts)

    Supervisor.start_link(__MODULE__, opts, name: config.name)
  end

  def child_spec(opts) do
    opts
    |> super()
    |> Supervisor.child_spec(id: Keyword.get(opts, :name, __MODULE__))
  end

  @impl true
  def init(opts) do
    config = Config.validate!(opts)

    children = [
      {Blockfrost.Config, config},
      {Finch, name: Module.concat(config.name, Finch)},
      {Task.Supervisor, name: Module.concat(config.name, TaskSupervisor)}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  @doc "Get config from a running Blockfrost client"
  def config(name) do
    if Process.whereis(name) do
      Blockfrost.Config.read(name)
    else
      raise ArgumentError,
            "No running instance for name #{name}, did you start Blockfrost in your supervision tree?"
    end
  end
end
