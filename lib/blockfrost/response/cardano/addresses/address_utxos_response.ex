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

  def cast(body) do
    Enum.map(body, &UTXO.cast/1)
  end
end
