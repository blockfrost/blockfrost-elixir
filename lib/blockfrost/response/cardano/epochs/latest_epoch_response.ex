defmodule Blockfrost.Response.LatestEpochResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: Blockfrost.Shared.Epoch.t()

  @doc false
  defdelegate cast(body), to: Blockfrost.Shared.Epoch
end
