defmodule Blockfrost.Case do
  defmacro __using__(opts) do
    quote do
      use ExUnit.Case, unquote(opts)

      import Mox
      import Blockfrost.Case

      setup :verify_on_exit!
    end
  end

  @spec response(pos_integer(), map()) :: Finch.Response.t()
  def response(status, body) do
    encoded_body = Jason.encode!(body)

    {:ok,
     %Finch.Response{
       status: status,
       body: encoded_body,
       headers: [{"Content-Type", "application/json"}]
     }}
  end
end
