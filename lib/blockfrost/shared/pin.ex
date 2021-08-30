defmodule Blockfrost.Shared.PinnedObject do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          time_created: integer(),
          time_pinned: integer(),
          ipfs_hash: String.t(),
          size: integer(),
          state: :queued | :pinned | :unpinned | :failed | :gc
        }

  embedded_schema do
    field(:time_created, :integer)
    field(:time_pinned, :integer)
    field(:ipfs_hash, :string)
    field(:size, :integer)
    field(:state, Ecto.Enum, values: [:queued, :pinned, :unpinned, :failed, :gc])
  end
end
