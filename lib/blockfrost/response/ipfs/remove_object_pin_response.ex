defmodule Blockfrost.Response.RemoveObjectPinResponse do
  @type t :: Blockfrost.Shared.ObjectPinInfo.t()

  @doc false
  defdelegate cast(body), to: Blockfrost.Shared.ObjectPinInfo
end
