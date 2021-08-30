defmodule Blockfrost.Response.BlockDistributionResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: [String.t()]

  @doc false
  def cast(body), do: body
end
