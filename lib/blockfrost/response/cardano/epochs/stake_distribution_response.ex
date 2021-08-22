defmodule Blockfrost.Response.StakeDistributionResponse do
  defmodule Stake do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:stake_address, :string)
      field(:pool_id, :string)
      field(:amount, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &Stake.cast/1)
  end
end
