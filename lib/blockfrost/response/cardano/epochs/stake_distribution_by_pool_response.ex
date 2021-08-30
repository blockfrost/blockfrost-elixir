defmodule Blockfrost.Response.StakeDistributionByPoolResponse do
  defmodule Stake do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:stake_address, :string)
      field(:amount, :string)
    end
  end

  @type t :: [%Stake{stake_address: String.t(), amount: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &Stake.cast/1)
  end
end
