defmodule Blockfrost.Shared.Block do
  use Blockfrost.Response.BaseSchema

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
