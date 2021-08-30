defmodule Blockfrost.Shared.Epoch do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          epoch: integer(),
          start_time: integer(),
          end_time: integer(),
          first_block_time: integer(),
          last_block_time: integer(),
          block_count: integer(),
          tx_count: integer(),
          output: String.t(),
          fees: String.t(),
          active_stake: String.t() | nil
        }

  embedded_schema do
    field(:epoch, :integer)
    field(:start_time, :integer)
    field(:end_time, :integer)
    field(:first_block_time, :integer)
    field(:last_block_time, :integer)
    field(:block_count, :integer)
    field(:tx_count, :integer)
    field(:output, :string)
    field(:fees, :string)
    field(:active_stake, :string)
  end
end
