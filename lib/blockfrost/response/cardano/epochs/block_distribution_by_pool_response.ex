defmodule Blockfrost.Response.BlockDistributionByPoolResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: [String.t()]

  def cast(body), do: body
end
