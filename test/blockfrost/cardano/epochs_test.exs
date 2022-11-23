defmodule Blockfrost.Cardano.EpochsTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Epochs

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Shared.Epoch
  alias Blockfrost.Shared.ProtocolParameters

  alias Blockfrost.Response.{
    StakeDistributionResponse,
    StakeDistributionByPoolResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  @sample_epoch_number 225

  @sample_epoch %{
    epoch: 225,
    start_time: 1_603_403_091,
    end_time: 1_603_835_086,
    first_block_time: 1_603_403_092,
    last_block_time: 1_603_835_084,
    block_count: 21_298,
    tx_count: 17_856,
    output: "7849943934049314",
    fees: "4203312194",
    active_stake: "784953934049314"
  }

  @decoded_sample_epoch %Epoch{
    epoch: 225,
    start_time: 1_603_403_091,
    end_time: 1_603_835_086,
    first_block_time: 1_603_403_092,
    last_block_time: 1_603_835_084,
    block_count: 21_298,
    tx_count: 17_856,
    output: "7849943934049314",
    fees: "4203312194",
    active_stake: "784953934049314"
  }

  @sample_protocol_parameters %{
    epoch: 225,
    min_fee_a: 44,
    min_fee_b: 155_381,
    max_block_size: 65_536,
    max_tx_size: 16_384,
    max_block_header_size: 1100,
    key_deposit: "2000000",
    pool_deposit: "500000000",
    e_max: 18,
    n_opt: 150,
    a0: 0.3,
    rho: 0.003,
    tau: 0.2,
    decentralisation_param: 0.5,
    extra_entropy: nil,
    protocol_major_ver: 2,
    protocol_minor_ver: 0,
    min_utxo: "1000000",
    min_pool_cost: "340000000",
    nonce: "1a3be38bcbb7911969283716ad7aa550250226b76a61fc51cc9a9a35d9276d81"
  }

  @decoded_sample_protocol_parameters %ProtocolParameters{
    epoch: 225,
    min_fee_a: 44,
    min_fee_b: 155_381,
    max_block_size: 65_536,
    max_tx_size: 16_384,
    max_block_header_size: 1100,
    key_deposit: "2000000",
    pool_deposit: "500000000",
    e_max: 18,
    n_opt: 150,
    a0: 0.3,
    rho: 0.003,
    tau: 0.2,
    decentralisation_param: 0.5,
    extra_entropy: nil,
    protocol_major_ver: 2,
    protocol_minor_ver: 0,
    min_utxo: "1000000",
    min_pool_cost: "340000000",
    nonce: "1a3be38bcbb7911969283716ad7aa550250226b76a61fc51cc9a9a35d9276d81"
  }

  describe "latest_epoch/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/latest"

        response(200, @sample_epoch)
      end)

      assert {:ok, @decoded_sample_epoch} == Epochs.latest_epoch(Blockfrost)
    end
  end

  describe "latest_epoch_protocol_parameters/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/latest/parameters"

        response(200, @sample_protocol_parameters)
      end)

      assert {:ok, @decoded_sample_protocol_parameters} ==
               Epochs.latest_epoch_protocol_parameters(Blockfrost)
    end
  end

  describe "specific_epoch/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}"

        response(200, @sample_epoch)
      end)

      assert {:ok, @decoded_sample_epoch} ==
               Epochs.specific_epoch(Blockfrost, @sample_epoch_number)
    end
  end

  describe "listing_of_next_epochs/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/next"

        response(200, [@sample_epoch])
      end)

      assert {:ok, [@decoded_sample_epoch]} ==
               Epochs.listing_of_next_epochs(Blockfrost, @sample_epoch_number)
    end
  end

  describe "listing_of_previous_epochs/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/previous"

        response(200, [@sample_epoch])
      end)

      assert {:ok, [@decoded_sample_epoch]} ==
               Epochs.listing_of_previous_epochs(Blockfrost, @sample_epoch_number)
    end
  end

  describe "stake_distribution/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/stakes"

        response(
          200,
          [
            %{
              stake_address: "stake1u9l5q5jwgelgagzyt6nuaasefgmn8pd25c8e9qpeprq0tdcp0e3uk",
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
              amount: "4440295078"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %StakeDistributionResponse.Stake{
                  stake_address: "stake1u9l5q5jwgelgagzyt6nuaasefgmn8pd25c8e9qpeprq0tdcp0e3uk",
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                  amount: "4440295078"
                }
              ]} ==
               Epochs.stake_distribution(Blockfrost, @sample_epoch_number)
    end
  end

  describe "stake_distribution_by_pool/2,3,4" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/stakes/af10"

        response(
          200,
          [
            %{
              stake_address: "stake1u9l5q5jwgelgagzyt6nuaasefgmn8pd25c8e9qpeprq0tdcp0e3uk",
              amount: "4440295078"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %StakeDistributionByPoolResponse.Stake{
                  stake_address: "stake1u9l5q5jwgelgagzyt6nuaasefgmn8pd25c8e9qpeprq0tdcp0e3uk",
                  amount: "4440295078"
                }
              ]} ==
               Epochs.stake_distribution_by_pool(Blockfrost, @sample_epoch_number, "af10")
    end
  end

  describe "block_distribution/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/blocks"

        response(
          200,
          [
            "d0fa315687e99ccdc96b14cc2ea74a767405d64427b648c470731a9b69e4606e",
            "38bc6efb92a830a0ed22a64f979d120d26483fd3c811f6622a8c62175f530878",
            "f3258fcd8b975c061b4fcdcfcbb438807134d6961ec278c200151274893b6b7d"
          ]
        )
      end)

      assert {:ok,
              [
                "d0fa315687e99ccdc96b14cc2ea74a767405d64427b648c470731a9b69e4606e",
                "38bc6efb92a830a0ed22a64f979d120d26483fd3c811f6622a8c62175f530878",
                "f3258fcd8b975c061b4fcdcfcbb438807134d6961ec278c200151274893b6b7d"
              ]} ==
               Epochs.block_distribution(Blockfrost, @sample_epoch_number)
    end
  end

  describe "block_distribution_by_pool/2,3,4" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/blocks/af10"

        response(
          200,
          [
            "d0fa315687e99ccdc96b14cc2ea74a767405d64427b648c470731a9b69e4606e",
            "38bc6efb92a830a0ed22a64f979d120d26483fd3c811f6622a8c62175f530878",
            "f3258fcd8b975c061b4fcdcfcbb438807134d6961ec278c200151274893b6b7d"
          ]
        )
      end)

      assert {:ok,
              [
                "d0fa315687e99ccdc96b14cc2ea74a767405d64427b648c470731a9b69e4606e",
                "38bc6efb92a830a0ed22a64f979d120d26483fd3c811f6622a8c62175f530878",
                "f3258fcd8b975c061b4fcdcfcbb438807134d6961ec278c200151274893b6b7d"
              ]} ==
               Epochs.block_distribution_by_pool(Blockfrost, @sample_epoch_number, "af10")
    end
  end

  describe "protocol_parameters/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/epochs/#{@sample_epoch_number}/parameters"

        response(200, @sample_protocol_parameters)
      end)

      assert {:ok, @decoded_sample_protocol_parameters} ==
               Epochs.protocol_parameters(Blockfrost, @sample_epoch_number)
    end
  end
end
