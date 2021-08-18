defmodule Blockfrost.Response.AddressDetailsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Sum do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:unit, :string)
      field(:quantity, :string)
    end
  end

  embedded_schema do
    field(:address, :string)
    field(:tx_count, :integer)
    embeds_many(:received_sum, Sum)
    embeds_many(:sent_sum, Sum)
  end
end
