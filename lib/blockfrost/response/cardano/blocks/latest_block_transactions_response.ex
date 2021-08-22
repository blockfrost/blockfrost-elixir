defmodule Blockfrost.Response.LatestBlockTransactionsResponse do
  use Blockfrost.Response.BaseSchema

  def cast(body), do: body
end
