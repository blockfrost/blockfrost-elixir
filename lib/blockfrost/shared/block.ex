defmodule Blockfrost.Shared.Block do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          time: integer(),
          height: integer() | nil,
          hash: String.t(),
          slot: integer() | nil,
          epoch: integer() | nil,
          epoch_slot: integer() | nil,
          slot_leader: String.t(),
          size: integer(),
          tx_count: integer(),
          output: String.t() | nil,
          fees: String.t() | nil,
          block_vrf: String.t() | nil,
          previous_block: String.t() | nil,
          next_block: String.t() | nil,
          confirmations: integer()
        }

  embedded_schema do
    field(:time, :integer)
    field(:height, :integer)
    field(:hash, :string)
    field(:slot, :integer)
    field(:epoch, :integer)
    field(:epoch_slot, :integer)
    field(:slot_leader, :string)
    field(:size, :integer)
    field(:tx_count, :integer)
    field(:output, :string)
    field(:fees, :string)
    field(:block_vrf, :string)
    field(:previous_block, :string)
    field(:next_block, :string)
    field(:confirmations, :integer)
  end
end
