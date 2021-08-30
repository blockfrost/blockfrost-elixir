defmodule Blockfrost.Response.AddressDetailsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Sum do
    use Blockfrost.Response.BaseSchema
    @type t :: %__MODULE__{unit: String.t(), quantity: String.t()}

    embedded_schema do
      field(:unit, :string)
      field(:quantity, :string)
    end
  end

  @type t :: %__MODULE__{
          address: String.t(),
          tx_count: integer(),
          received_sum: [Sum.t()],
          sent_sum: [Sum.t()]
        }

  embedded_schema do
    field(:address, :string)
    field(:tx_count, :integer)
    embeds_many(:received_sum, Sum)
    embeds_many(:sent_sum, Sum)
  end
end
