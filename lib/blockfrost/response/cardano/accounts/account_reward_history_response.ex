defmodule Blockfrost.Response.AccountRewardHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Reward do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:epoch, :integer)
      field(:amount, :string)
      field(:pool_id, :string)
    end
  end

  @type t :: [%Reward{epoch: integer(), amount: String.t(), pool_id: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &Reward.cast/1)
  end
end
