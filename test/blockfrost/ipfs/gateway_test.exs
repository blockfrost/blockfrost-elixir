defmodule Blockfrost.IPFS.GatewayTest do
  use Blockfrost.Case

  alias Blockfrost.IPFS.Gateway

  alias Blockfrost.HTTPClientMock

  setup_all do
    start_supervised!({Blockfrost, name: IPFS, api_key: "apikey", network: :ipfs})
    :ok
  end

  describe "get" do
    test "doesn't decode response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/gateway/hash"
        assert request.method == "GET"

        response(200, "FOOBAR", encoding: :plaintext)
      end)

      assert {:ok, %{body: "FOOBAR"}} = Gateway.get(IPFS, "hash")
    end
  end
end
