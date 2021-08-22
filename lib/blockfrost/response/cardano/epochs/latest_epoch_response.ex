defmodule Blockfrost.Response.LatestEpochResponse do
  use Blockfrost.Response.BaseSchema

  defdelegate cast(body), to: Blockfrost.Shared.Epoch
end
