defmodule Blockfrost.HTTPClient do
  @moduledoc """
  Behaviour for HTTP clients to be used by the SDK. 

  This behaviour is specific to finch and finch mocking.
  """

  @callback request(Finch.Request.t(), atom, Keyword.t()) :: Finch.Response.t()
end
