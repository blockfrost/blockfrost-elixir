defmodule Blockfrost.Response.SpecificTransactionResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          hash: String.t(),
          block: String.t(),
          block_height: integer(),
          slot: integer(),
          index: integer(),
          output_amount: list(Blockfrost.Shared.Amount.t()),
          fees: String.t(),
          deposit: String.t(),
          size: integer(),
          invalid_before: String.t() | nil,
          invalid_hereafter: String.t() | nil,
          utxo_count: integer(),
          withdrawal_count: integer(),
          mir_cert_count: integer(),
          delegation_count: integer(),
          stake_cert_count: integer(),
          pool_update_count: integer(),
          pool_retire_count: integer(),
          asset_mint_or_burn_count: integer(),
          redeemer_count: integer()
        }

  embedded_schema do
    field(:hash, :string)
    field(:block, :string)
    field(:block_height, :integer)
    field(:slot, :integer)
    field(:index, :integer)
    embeds_many(:output_amount, Blockfrost.Shared.Amount)
    field(:fees, :string)
    field(:deposit, :string)
    field(:size, :integer)
    field(:invalid_before, :string)
    field(:invalid_hereafter, :string)
    field(:utxo_count, :integer)
    field(:withdrawal_count, :integer)
    field(:mir_cert_count, :integer)
    field(:delegation_count, :integer)
    field(:stake_cert_count, :integer)
    field(:pool_update_count, :integer)
    field(:pool_retire_count, :integer)
    field(:asset_mint_or_burn_count, :integer)
    field(:redeemer_count, :integer)
  end
end
