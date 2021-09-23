defmodule Blockfrost.Response.TransactionWithdrawalsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Withdrawal do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:address, :string)
      field(:amount, :string)
    end
  end

  @type t :: [
          %Withdrawal{
            amount: String.t(),
            address: String.t()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &Withdrawal.cast/1)
  end
end
