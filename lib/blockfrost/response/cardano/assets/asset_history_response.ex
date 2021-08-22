defmodule Blockfrost.Response.AssetHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule AssetHistory do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:amount, :string)
      field(:action, Ecto.Enum, values: [:minted, :burned])
    end
  end

  def cast(body) do
    Enum.map(body, &AssetHistory.cast/1)
  end
end
