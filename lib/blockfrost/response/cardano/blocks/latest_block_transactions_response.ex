defmodule Blockfrost.Response.LatestBlockTransactionsResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: [String.t()]

  @doc false
  def cast(body), do: body
end
