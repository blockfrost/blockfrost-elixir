defmodule Blockfrost.Response.SpecificAddressResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          address: String.t(),
          stake_address: String.t(),
          type: :byron | :shelley,
          amount: Blockfrost.Shared.Amount.t()
        }

  embedded_schema do
    field(:address, :string)
    field(:stake_address, :string)
    field(:type, Ecto.Enum, values: [:byron, :shelley])
    embeds_many(:amount, Blockfrost.Shared.Amount)
  end
end
