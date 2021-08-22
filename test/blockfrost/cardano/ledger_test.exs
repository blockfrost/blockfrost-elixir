defmodule Blockfrost.Cardano.LedgerTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Ledger

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.BlockchainGenesisResponse

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "blockchain_genesis/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/genesis"

        response(
          200,
          %{
            active_slots_coefficient: 0.05,
            update_quorum: 5,
            max_lovelace_supply: "45000000000000000",
            network_magic: 764_824_073,
            epoch_length: 432_000,
            system_start: 1_506_203_091,
            slots_per_kes_period: 129_600,
            slot_length: 1,
            max_kes_evolutions: 62,
            security_param: 2160
          }
        )
      end)

      assert {:ok,
              %BlockchainGenesisResponse{
                active_slots_coefficient: 0.05,
                update_quorum: 5,
                max_lovelace_supply: "45000000000000000",
                network_magic: 764_824_073,
                epoch_length: 432_000,
                system_start: 1_506_203_091,
                slots_per_kes_period: 129_600,
                slot_length: 1,
                max_kes_evolutions: 62,
                security_param: 2160
              }} == Ledger.blockchain_genesis()
    end
  end
end
