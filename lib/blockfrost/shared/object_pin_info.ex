defmodule Blockfrost.Shared.ObjectPinInfo do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          ipfs_hash: String.t(),
          state: :queued | :pinned | :unpinned | :failed | :gc
        }

  embedded_schema do
    field(:ipfs_hash, :string)
    field(:state, Ecto.Enum, values: [:queued, :pinned, :unpinned, :failed, :gc])
  end
end
