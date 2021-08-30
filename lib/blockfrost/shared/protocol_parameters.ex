defmodule Blockfrost.Shared.ProtocolParameters do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          epoch: integer(),
          min_fee_a: integer(),
          min_fee_b: integer(),
          max_block_size: integer(),
          max_tx_size: integer(),
          max_block_header_size: integer(),
          key_deposit: String.t(),
          pool_deposit: String.t(),
          e_max: integer(),
          n_opt: integer(),
          a0: float(),
          rho: float(),
          tau: float(),
          decentralisation_param: float(),
          extra_entropy: term(),
          protocol_major_ver: integer(),
          protocol_minor_ver: integer(),
          min_utxo: String.t(),
          min_pool_cost: String.t(),
          nonce: String.t()
        }

  embedded_schema do
    field(:epoch, :integer)
    field(:min_fee_a, :integer)
    field(:min_fee_b, :integer)
    field(:max_block_size, :integer)
    field(:max_tx_size, :integer)
    field(:max_block_header_size, :integer)
    field(:key_deposit, :string)
    field(:pool_deposit, :string)
    field(:e_max, :integer)
    field(:n_opt, :integer)
    field(:a0, :float)
    field(:rho, :float)
    field(:tau, :float)
    field(:decentralisation_param, :float)
    field(:extra_entropy, :any, virtual: true)
    field(:protocol_major_ver, :integer)
    field(:protocol_minor_ver, :integer)
    field(:min_utxo, :string)
    field(:min_pool_cost, :string)
    field(:nonce, :string)
  end
end
