defmodule Blockfrost.Response.RemoveObjectPinResponse do
  defdelegate cast(body), to: Blockfrost.Shared.ObjectPinInfo
end
