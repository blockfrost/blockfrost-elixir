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

  @type t :: [%AssetHistory{tx_hash: String.t(), amount: String.t(), action: :minted | :burned}]

  @doc false
  def cast(body) do
    Enum.map(body, &AssetHistory.cast/1)
  end
end
