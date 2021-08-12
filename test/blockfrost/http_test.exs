defmodule Blockfrost.HTTPTest do
  use Blockfrost.Case

  alias Blockfrost.HTTPClientMock
  alias Blockfrost.HTTP

  setup_all do
    start_supervised!({Blockfrost, name: TestNet, api_key: "apikey", network: :cardano_testnet})
    start_supervised!({Blockfrost, name: MainNet, api_key: "apikey", network: :cardano_mainnet})
    :ok
  end

  describe "build/2,3,4" do
    test "uses host for network" do
      test_req = HTTP.build(TestNet, :get, "/")
      main_req = HTTP.build(MainNet, :get, "/")

      refute test_req.host == main_req.host
    end

    test "merges path with base path" do
      req = HTTP.build(MainNet, :get, "/foo")

      base_path =
        MainNet
        |> Blockfrost.config()
        |> Map.get(:network_uri)
        |> Map.get(:path)

      assert req.path == base_path <> "/foo"
    end
  end

  describe "request/1,2,3" do
    test "returns treated errors" do
      expect(HTTPClientMock, :request, fn _req, _finch, _opts ->
        response(418, [])
      end)

      req = HTTP.build(MainNet, :get, "/foo")
      assert {:error, :ip_banned} = HTTP.request(MainNet, req)
    end

    test "retries if receives a retryable status" do
      # expected 3 times
      expect(HTTPClientMock, :request, 3, fn _req, _finch, _opts ->
        response(429, [])
      end)

      # on fourth, we return a success
      expect(HTTPClientMock, :request, fn _req, _finch, _opts ->
        response(200, %{})
      end)

      req = HTTP.build(MainNet, :get, "/foo")
      assert {:ok, %{status: 200}} = HTTP.request(MainNet, req)
    end

    test "returns error if surpassing max retries amount" do
      expect(HTTPClientMock, :request, 5, fn _req, _finch, _opts ->
        response(429, [])
      end)

      req = HTTP.build(MainNet, :get, "/foo")
      assert {:error, :usage_limit_reached} = HTTP.request(MainNet, req, retry_max_attempts: 5)
    end
  end
end
