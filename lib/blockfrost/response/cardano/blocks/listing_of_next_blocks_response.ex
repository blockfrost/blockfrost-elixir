defmodule Blockfrost.Response.ListingOfNextBlocksResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: Blockfrost.Shared.Block.t()

  @doc false
  def cast(body), do: Enum.map(body, &Blockfrost.Shared.Block.cast/1)
end
