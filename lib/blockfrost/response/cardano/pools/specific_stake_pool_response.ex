defmodule Blockfrost.Response.SpecificStakePoolResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          pool_id: String.t(),
          hex: String.t(),
          vrf_key: String.t(),
          blocks_minted: integer(),
          live_stake: String.t(),
          live_size: float(),
          live_saturation: float(),
          live_delegators: integer(),
          active_stake: String.t(),
          active_size: float(),
          declared_pledge: String.t(),
          live_pledge: String.t(),
          margin_cost: float(),
          fixed_cost: String.t(),
          reward_account: String.t(),
          owners: list(String.t()),
          registration: list(String.t()),
          retirement: list(String.t())
        }

  embedded_schema do
    field(:pool_id, :string)
    field(:hex, :string)
    field(:vrf_key, :string)
    field(:blocks_minted, :integer)
    field(:live_stake, :string)
    field(:live_size, :float)
    field(:live_saturation, :float)
    field(:live_delegators, :integer)
    field(:active_stake, :string)
    field(:active_size, :float)
    field(:declared_pledge, :string)
    field(:live_pledge, :string)
    field(:margin_cost, :float)
    field(:fixed_cost, :string)
    field(:reward_account, :string)
    field(:owners, {:array, :string})
    field(:registration, {:array, :string})
    field(:retirement, {:array, :string})
  end
end
