defmodule Blockfrost.Response.ListingOfPreviousBlocksResponse do
  use Blockfrost.Response.BaseSchema

  def cast(body), do: Enum.map(body, &Blockfrost.Shared.Block.cast/1)
end
