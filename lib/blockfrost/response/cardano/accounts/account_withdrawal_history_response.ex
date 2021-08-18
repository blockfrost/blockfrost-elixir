defmodule Blockfrost.Response.AccountWithdrawalHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Withdrawal do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:amount, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &Withdrawal.cast/1)
  end
end
