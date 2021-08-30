defmodule Blockfrost.Response.SpecificBlockInSlotResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: Blockfrost.Shared.Block.t()

  @doc false
  defdelegate cast(body), to: Blockfrost.Shared.Block
end
