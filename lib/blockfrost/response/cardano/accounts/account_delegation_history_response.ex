defmodule Blockfrost.Response.AccountDelegationHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Delegation do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:active_epoch, :integer)
      field(:tx_hash, :string)
      field(:amount, :string)
      field(:pool_id, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &Delegation.cast/1)
  end
end
