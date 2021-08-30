defmodule Blockfrost.HTTPClient do
  @moduledoc false

  @callback request(Finch.Request.t(), atom, Keyword.t()) :: Finch.Response.t()
end
