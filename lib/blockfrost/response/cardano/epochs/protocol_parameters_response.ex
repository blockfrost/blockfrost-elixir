defmodule Blockfrost.Response.ProtocolParametersResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: Blockfrost.Shared.ProtocolParameters.t()

  @doc false
  defdelegate cast(body), to: Blockfrost.Shared.ProtocolParameters
end
