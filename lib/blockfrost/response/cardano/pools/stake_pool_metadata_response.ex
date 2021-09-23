defmodule Blockfrost.Response.StakePoolMetadataResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: Blockfrost.Shared.StakePoolMetadata.t()

  defdelegate cast(data), to: Blockfrost.Shared.StakePoolMetadata
end
