defmodule Blockfrost.API.HealthTest do
  use Blockfrost.Case

  alias Blockfrost.API.Health

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    RootResponse,
    BackendHealthStatusResponse,
    CurrentBackendTimeResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "root/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/"

        response(200, %{
          "url" => "https://blockfrost.io/",
          "version" => "0.1.0"
        })
      end)

      assert {:ok, %RootResponse{url: "https://blockfrost.io/", version: "0.1.0"}} =
               Health.root(Blockfrost)
    end
  end

  describe "backend_health_status/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path =~ "/health"

        response(200, %{
          "is_healthy" => true
        })
      end)

      assert {:ok, %BackendHealthStatusResponse{is_healthy: true}} =
               Health.backend_health_status(Blockfrost)
    end
  end

  describe "current_backend_time/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path =~ "/health"

        response(200, %{
          "server_time" => 1_603_400_958_947
        })
      end)

      assert {:ok, %CurrentBackendTimeResponse{server_time: 1_603_400_958_947}} =
               Health.current_backend_time(Blockfrost)
    end
  end
end
