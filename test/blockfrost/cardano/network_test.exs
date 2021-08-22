defmodule Blockfrost.Cardano.NetworkTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Network

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.NetworkInformationResponse

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "blockchain_genesis/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/network"

        response(
          200,
          %{
            supply: %{
              max: "45000000000000000",
              total: "32890715183299160",
              circulating: "32412601976210393"
            },
            stake: %{
              live: "23204950463991654",
              active: "22210233523456321"
            }
          }
        )
      end)

      assert {:ok,
              %NetworkInformationResponse{
                supply: %NetworkInformationResponse.Supply{
                  max: "45000000000000000",
                  total: "32890715183299160",
                  circulating: "32412601976210393"
                },
                stake: %NetworkInformationResponse.Stake{
                  live: "23204950463991654",
                  active: "22210233523456321"
                }
              }} == Network.network_info()
    end
  end
end
