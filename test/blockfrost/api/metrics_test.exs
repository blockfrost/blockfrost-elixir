defmodule Blockfrost.API.MetricsTest do
  use Blockfrost.Case

  alias Blockfrost.API.Metrics

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    BlockfrostEndpointUsageMetricsResponse,
    BlockfrostUsageMetricsResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "blockfrost_usage_metrics/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path =~ "/metrics"

        response(200, [
          %{
            "time" => 1_612_543_884,
            "calls" => 42
          },
          %{
            "time" => 1_614_523_884,
            "calls" => 6942
          }
        ])
      end)

      assert {:ok,
              [
                %BlockfrostUsageMetricsResponse.Metric{time: 1_612_543_884, calls: 42},
                %BlockfrostUsageMetricsResponse.Metric{
                  time: 1_614_523_884,
                  calls: 6942
                }
              ]} = Metrics.blockfrost_usage_metrics(Blockfrost)
    end
  end

  describe "blockfrost_endpoint_usage_metrics/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path =~ "/metrics"

        response(
          200,
          [
            %{
              "time" => 1_612_543_814,
              "calls" => 182,
              "endpoint" => "block"
            },
            %{
              "time" => 1_612_543_814,
              "calls" => 42,
              "endpoint" => "epoch"
            },
            %{
              "time" => 1_612_543_812,
              "calls" => 775,
              "endpoint" => "block"
            },
            %{
              "time" => 1_612_523_884,
              "calls" => 4,
              "endpoint" => "epoch"
            },
            %{
              "time" => 1_612_553_884,
              "calls" => 89794,
              "endpoint" => "block"
            }
          ]
        )
      end)

      assert {
               :ok,
               [
                 %BlockfrostEndpointUsageMetricsResponse.Metric{
                   calls: 182,
                   endpoint: "block",
                   time: 1_612_543_814
                 },
                 %BlockfrostEndpointUsageMetricsResponse.Metric{
                   calls: 42,
                   endpoint: "epoch",
                   time: 1_612_543_814
                 },
                 %BlockfrostEndpointUsageMetricsResponse.Metric{
                   calls: 775,
                   endpoint: "block",
                   time: 1_612_543_812
                 },
                 %BlockfrostEndpointUsageMetricsResponse.Metric{
                   calls: 4,
                   endpoint: "epoch",
                   time: 1_612_523_884
                 },
                 %BlockfrostEndpointUsageMetricsResponse.Metric{
                   calls: 89794,
                   endpoint: "block",
                   time: 1_612_553_884
                 }
               ]
             } = Metrics.blockfrost_endpoint_usage_metrics(Blockfrost)
    end
  end
end
