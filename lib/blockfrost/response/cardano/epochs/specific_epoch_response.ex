defmodule Blockfrost.Response.SpecificEpochResponse do
  use Blockfrost.Response.BaseSchema

  defdelegate cast(body), to: Blockfrost.Shared.Epoch
end
