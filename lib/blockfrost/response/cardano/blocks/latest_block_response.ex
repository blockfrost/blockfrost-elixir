defmodule Blockfrost.Response.LatestBlockResponse do
  use Blockfrost.Response.BaseSchema

  defdelegate cast(body), to: Blockfrost.Shared.Block
end
