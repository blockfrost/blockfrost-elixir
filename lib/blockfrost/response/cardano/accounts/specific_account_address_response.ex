defmodule Blockfrost.Response.SpecificAccountAddressResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          stake_address: String.t(),
          active: boolean(),
          active_epoch: integer(),
          controlled_amount: String.t(),
          rewards_sum: String.t(),
          withdrawals_sum: String.t(),
          reserves_sum: String.t(),
          treasury_sum: String.t(),
          withdrawable_amount: String.t(),
          pool_id: String.t() | nil
        }

  embedded_schema do
    field(:stake_address, :string)
    field(:active, :boolean)
    field(:active_epoch, :integer)
    field(:controlled_amount, :string)
    field(:rewards_sum, :string)
    field(:withdrawals_sum, :string)
    field(:reserves_sum, :string)
    field(:treasury_sum, :string)
    field(:withdrawable_amount, :string)
    field(:pool_id, :string)
  end
end
