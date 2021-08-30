defmodule Blockfrost.Response.ListingOfPreviousEpochsResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: [Blockfrost.Shared.Epoch.t()]

  @doc false
  def cast(body), do: Enum.map(body, &Blockfrost.Shared.Epoch.cast/1)
end
