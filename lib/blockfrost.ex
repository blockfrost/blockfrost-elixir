defmodule Blockfrost do
  @moduledoc """
  Documentation for `Blockfrost`.
  """

  use Supervisor

  alias Blockfrost.Config

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
    Blockfrost.Config.read(name)
  end
end
