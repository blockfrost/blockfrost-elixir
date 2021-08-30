defmodule Blockfrost.Response.ListPinnedObjectsResponse do
  @type t :: [Blockfrost.Shared.PinnedObject.t()]

  @doc false
  def cast(body) do
    Enum.map(body, &Blockfrost.Shared.PinnedObject.cast/1)
  end
end
