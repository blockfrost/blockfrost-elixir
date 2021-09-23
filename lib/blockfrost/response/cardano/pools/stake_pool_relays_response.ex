defmodule Blockfrost.Response.StakePoolRelaysResponse do
  @type t :: [Blockfrost.Shared.StakePoolRelay.t()]

  @doc false
  def cast(body), do: Enum.map(body, &Blockfrost.Shared.StakePoolRelay.cast/1)
end
