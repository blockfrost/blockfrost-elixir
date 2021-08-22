defmodule Blockfrost.Response.SpecificBlockResponse do
  use Blockfrost.Response.BaseSchema

  defdelegate cast(body), to: Blockfrost.Shared.Block
end
