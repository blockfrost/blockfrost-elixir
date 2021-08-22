defmodule Blockfrost.Response.ProtocolParametersResponse do
  use Blockfrost.Response.BaseSchema

  defdelegate cast(body), to: Blockfrost.Shared.ProtocolParameters
end
