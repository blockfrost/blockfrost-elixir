defmodule Blockfrost.Response.AddressUTXOsResponse do
  defmodule UTXO do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:output_index, :integer)
      field(:block, :string)
      embeds_many(:amount, Blockfrost.Shared.Amount)
    end
  end

  @type t :: [
          %UTXO{
            tx_hash: String.t(),
            output_index: integer(),
            block: String.t(),
            amount: [Blockfrost.Shared.Amount.t()]
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &UTXO.cast/1)
  end
end
