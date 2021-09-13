defmodule Blockfrost.Response.StakePoolDelegatorsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule StakePoolDelegator do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:address, :string)
      field(:live_stake, :string)
    end
  end

  @type t :: [
          %StakePoolDelegator{
            address: String.t(),
            live_stake: String.t()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &StakePoolDelegator.cast/1)
end
