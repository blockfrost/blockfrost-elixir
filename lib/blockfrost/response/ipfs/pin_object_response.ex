defmodule Blockfrost.Response.PinObjectResponse do
  defdelegate cast(body), to: Blockfrost.Shared.ObjectPinInfo
end
