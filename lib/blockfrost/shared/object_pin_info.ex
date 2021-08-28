defmodule Blockfrost.Shared.ObjectPinInfo do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:ipfs_hash, :string)
    field(:state, Ecto.Enum, values: [:queued, :pinned, :unpinned, :failed, :gc])
  end
end
