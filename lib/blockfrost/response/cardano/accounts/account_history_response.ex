defmodule Blockfrost.Response.AccountHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule History do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:active_epoch, :integer)
      field(:amount, :string)
      field(:pool_id, :string)
    end
  end

  @type t :: [%History{active_epoch: integer(), amount: String.t(), pool_id: String.t()}]

  def cast(body) do
    Enum.map(body, &History.cast/1)
  end
end
