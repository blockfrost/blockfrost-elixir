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
  def response(status, body, opts \\ []) do
    {content_type, encoded_body} =
      case Keyword.get(opts, :encoding, :json) do
        :json ->
          {"application/json", Jason.encode!(body)}

        :plaintext ->
          {"text/plain", body}
      end

    {:ok,
     %Finch.Response{
       status: status,
       body: encoded_body,
       headers: [{"Content-Type", content_type}]
     }}
  end
end
