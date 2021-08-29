defmodule Blockfrost.Cardano.MetadataTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Metadata

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    TransactionMetadataLabelsResponse,
    TransactionMetadataContentJSONResponse,
    TransactionMetadataContentCBORResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "transaction_metadata_labels/1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/metadata/txs/labels"

        response(
          200,
          [
            %{
              label: "1990",
              cip10: nil,
              count: "1"
            },
            %{
              label: "1967",
              cip10: "nut.link metadata oracles registry",
              count: "3"
            },
            %{
              label: "1968",
              cip10: "nut.link metadata oracles data points",
              count: "16321"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionMetadataLabelsResponse.MetadataLabel{
                  label: "1990",
                  cip10: nil,
                  count: "1"
                },
                %TransactionMetadataLabelsResponse.MetadataLabel{
                  label: "1967",
                  cip10: "nut.link metadata oracles registry",
                  count: "3"
                },
                %TransactionMetadataLabelsResponse.MetadataLabel{
                  label: "1968",
                  cip10: "nut.link metadata oracles data points",
                  count: "16321"
                }
              ]} == Metadata.transaction_metadata_labels(Blockfrost)
    end
  end

  describe "transaction_metadata_content_json/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/metadata/txs/labels/felipe"

        response(
          200,
          [
            %{
              tx_hash: "257d75c8ddb0434e9b63e29ebb6241add2b835a307aa33aedba2effe09ed4ec8",
              json_metadata: %{
                ADAUSD: [
                  %{
                    value: "0.10409800535729975",
                    source: "ergoOracles"
                  }
                ]
              }
            },
            %{
              tx_hash: "e865f2cc01ca7381cf98dcdc4de07a5e8674b8ea16e6a18e3ed60c186fde2b9c",
              json_metadata: %{
                ADAUSD: [
                  %{
                    value: "0.15409850555139935",
                    source: "ergoOracles"
                  }
                ]
              }
            },
            %{
              tx_hash: "4237501da3cfdd53ade91e8911e764bd0699d88fd43b12f44a1f459b89bc91be",
              json_metadata: nil
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionMetadataContentJSONResponse.TransactionMetadataContent{
                  tx_hash: "257d75c8ddb0434e9b63e29ebb6241add2b835a307aa33aedba2effe09ed4ec8",
                  json_metadata: %{
                    "ADAUSD" => [
                      %{
                        "value" => "0.10409800535729975",
                        "source" => "ergoOracles"
                      }
                    ]
                  }
                },
                %TransactionMetadataContentJSONResponse.TransactionMetadataContent{
                  tx_hash: "e865f2cc01ca7381cf98dcdc4de07a5e8674b8ea16e6a18e3ed60c186fde2b9c",
                  json_metadata: %{
                    "ADAUSD" => [
                      %{
                        "value" => "0.15409850555139935",
                        "source" => "ergoOracles"
                      }
                    ]
                  }
                },
                %TransactionMetadataContentJSONResponse.TransactionMetadataContent{
                  tx_hash: "4237501da3cfdd53ade91e8911e764bd0699d88fd43b12f44a1f459b89bc91be",
                  json_metadata: nil
                }
              ]} == Metadata.transaction_metadata_content_json(Blockfrost, "felipe")
    end
  end

  describe "transaction_metadata_content_cbor/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/metadata/txs/labels/felipe/cbor"

        response(
          200,
          [
            %{
              tx_hash: "257d75c8ddb0434e9b63e29ebb6241add2b835a307aa33aedba2effe09ed4ec8",
              cbor_metadata: nil
            },
            %{
              tx_hash: "e865f2cc01ca7381cf98dcdc4de07a5e8674b8ea16e6a18e3ed60c186fde2b9c",
              cbor_metadata: nil
            },
            %{
              tx_hash: "4237501da3cfdd53ade91e8911e764bd0699d88fd43b12f44a1f459b89bc91be",
              cbor_metadata: "\\xa100a16b436f6d62696e6174696f6e8601010101010c"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionMetadataContentCBORResponse.TransactionMetadataContent{
                  tx_hash: "257d75c8ddb0434e9b63e29ebb6241add2b835a307aa33aedba2effe09ed4ec8",
                  cbor_metadata: nil
                },
                %TransactionMetadataContentCBORResponse.TransactionMetadataContent{
                  tx_hash: "e865f2cc01ca7381cf98dcdc4de07a5e8674b8ea16e6a18e3ed60c186fde2b9c",
                  cbor_metadata: nil
                },
                %TransactionMetadataContentCBORResponse.TransactionMetadataContent{
                  tx_hash: "4237501da3cfdd53ade91e8911e764bd0699d88fd43b12f44a1f459b89bc91be",
                  cbor_metadata: "\\xa100a16b436f6d62696e6174696f6e8601010101010c"
                }
              ]} == Metadata.transaction_metadata_content_cbor(Blockfrost, "felipe")
    end
  end
end
