defmodule Blockfrost.Response.AccountMIRHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule MIR do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:amount, :string)
    end
  end

  @type t :: [%MIR{tx_hash: String.t(), amount: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &MIR.cast/1)
  end
end
