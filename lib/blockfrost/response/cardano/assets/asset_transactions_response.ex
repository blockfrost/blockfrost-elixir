defmodule Blockfrost.Response.AssetTransactionsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Transaction do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:tx_index, :integer)
      field(:block_height, :integer)
    end
  end

  def cast(body) do
    Enum.map(body, &Transaction.cast/1)
  end
end
