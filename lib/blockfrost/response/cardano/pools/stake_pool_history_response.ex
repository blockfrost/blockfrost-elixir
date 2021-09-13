defmodule Blockfrost.Response.StakePoolHistoryResponse do
  defmodule StakePoolHistory do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:epoch, :integer)
      field(:blocks, :integer)
      field(:active_stake, :string)
      field(:active_size, :float)
      field(:delegators_count, :integer)
      field(:rewards, :string)
      field(:fees, :string)
    end
  end

  @type t :: [
          %StakePoolHistory{
            epoch: integer(),
            blocks: integer(),
            active_stake: String.t(),
            active_size: float(),
            delegators_count: integer(),
            rewards: String.t(),
            fees: String.t()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &StakePoolHistory.cast/1)
end
