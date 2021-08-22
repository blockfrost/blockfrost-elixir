defmodule Blockfrost.Response.BlockchainGenesisResponse do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:active_slots_coefficient, :float)
    field(:update_quorum, :integer)
    field(:max_lovelace_supply, :string)
    field(:network_magic, :integer)
    field(:epoch_length, :integer)
    field(:system_start, :integer)
    field(:slots_per_kes_period, :integer)
    field(:slot_length, :integer)
    field(:max_kes_evolutions, :integer)
    field(:security_param, :integer)
  end
end
