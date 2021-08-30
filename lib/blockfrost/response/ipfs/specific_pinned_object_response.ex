defmodule Blockfrost.Response.SpecificPinnedObjectResponse do
  @type t :: Blockfrost.Shared.PinnedObject.t()

  @doc false
  defdelegate cast(body), to: Blockfrost.Shared.PinnedObject
end
