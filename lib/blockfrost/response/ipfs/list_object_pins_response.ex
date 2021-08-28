defmodule Blockfrost.Response.ListPinnedObjectsResponse do
  def cast(body) do
    Enum.map(body, &Blockfrost.Shared.PinnedObject.cast/1)
  end
end
