defmodule Blockfrost.Response.SpecificPinnedObjectResponse do
  defdelegate cast(body), to: Blockfrost.Shared.PinnedObject
end
