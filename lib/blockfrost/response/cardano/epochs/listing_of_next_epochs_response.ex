defmodule Blockfrost.Response.ListingOfNextEpochsResponse do
  use Blockfrost.Response.BaseSchema

  def cast(body), do: Enum.map(body, &Blockfrost.Shared.Epoch.cast/1)
end
