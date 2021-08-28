defmodule Blockfrost.Shared.PinnedObject do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:time_created, :integer)
    field(:time_pinned, :integer)
    field(:ipfs_hash, :string)
    field(:size, :integer)
    field(:state, Ecto.Enum, values: [:queued, :pinned, :unpinned, :failed, :gc])
  end
end
