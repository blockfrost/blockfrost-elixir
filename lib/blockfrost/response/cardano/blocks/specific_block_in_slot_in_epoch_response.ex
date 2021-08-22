defmodule Blockfrost.Response.SpecificBlockInSlotInEpochResponse do
  use Blockfrost.Response.BaseSchema

  defdelegate cast(body), to: Blockfrost.Shared.Block
end
