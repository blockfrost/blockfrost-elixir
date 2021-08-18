defmodule Blockfrost.Response.SpecificAddressResponse do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:address, :string)
    field(:stake_address, :string)
    field(:type, Ecto.Enum, values: [:byron, :shelley])
    embeds_many(:amount, Blockfrost.Shared.Amount)
  end
end
