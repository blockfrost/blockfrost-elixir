defmodule Blockfrost.Response.SpecificEpochResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: Blockfrost.Shared.ProtocolParameters.t()

  @doc false
  defdelegate cast(body), to: Blockfrost.Shared.Epoch
end
