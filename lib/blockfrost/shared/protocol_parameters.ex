defmodule Blockfrost.Shared.ProtocolParameters do
  use Blockfrost.Response.BaseSchema

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
