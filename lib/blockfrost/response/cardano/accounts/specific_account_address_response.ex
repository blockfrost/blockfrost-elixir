defmodule Blockfrost.Response.SpecificAccountAddressResponse do
  use Blockfrost.Response.BaseSchema

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
