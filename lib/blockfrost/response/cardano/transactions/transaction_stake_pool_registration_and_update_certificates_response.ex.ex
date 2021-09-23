defmodule Blockfrost.Response.TransactionStakePoolRegistrationAndUpdateCertificatesResponse do
  defmodule Certificate do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:cert_index, :integer)
      field(:pool_id, :string)
      field(:vrf_key, :string)
      field(:pledge, :string)
      field(:margin_cost, :float)
      field(:fixed_cost, :string)
      field(:reward_account, :string)
      field(:owners, {:array, :string})
      embeds_one(:metadata, Blockfrost.Shared.StakePoolMetadata)
      embeds_many(:relays, Blockfrost.Shared.StakePoolRelay)
      field(:active_epoch, :integer)
    end
  end

  @type t :: [
          %Certificate{
            cert_index: integer(),
            pool_id: String.t(),
            vrf_key: String.t(),
            pledge: String.t(),
            margin_cost: number(),
            fixed_cost: String.t(),
            reward_account: String.t(),
            owners: list(String.t()),
            metadata: Blockfrost.Shared.StakePoolMetadata.t() | nil,
            relays: Blockfrost.Shared.StakePoolRelay.t(),
            active_epoch: integer()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &Certificate.cast/1)
  end
end
