defmodule Blockfrost.Cardano.BlocksTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Blocks

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Shared.Block

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  @sample_block %{
    time: 1_641_338_934,
    height: 15_243_593,
    hash: "4ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a",
    slot: 412_162_133,
    epoch: 425,
    epoch_slot: 12,
    slot_leader: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2qnikdy",
    size: 3,
    tx_count: 1,
    output: "128314491794",
    fees: "592661",
    block_vrf: "vrf_vk1wf2k6lhujezqcfe00l6zetxpnmh9n6mwhpmhm0dvfh3fxgmdnrfqkms8ty",
    previous_block: "43ebccb3ac72c7cebd0d9b755a4b08412c9f5dcb81b8a0ad1e3c197d29d47b05",
    next_block: "8367f026cf4b03e116ff8ee5daf149b55ba5a6ec6dec04803b8dc317721d15fa",
    confirmations: 4698
  }

  @decoded_sample_block %Block{
    time: 1_641_338_934,
    height: 15_243_593,
    hash: "4ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a",
    slot: 412_162_133,
    epoch: 425,
    epoch_slot: 12,
    slot_leader: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2qnikdy",
    size: 3,
    tx_count: 1,
    output: "128314491794",
    fees: "592661",
    block_vrf: "vrf_vk1wf2k6lhujezqcfe00l6zetxpnmh9n6mwhpmhm0dvfh3fxgmdnrfqkms8ty",
    previous_block: "43ebccb3ac72c7cebd0d9b755a4b08412c9f5dcb81b8a0ad1e3c197d29d47b05",
    next_block: "8367f026cf4b03e116ff8ee5daf149b55ba5a6ec6dec04803b8dc317721d15fa",
    confirmations: 4698
  }

  describe "latest_block/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/blocks/latest"

        response(200, @sample_block)
      end)

      assert {:ok, @decoded_sample_block} == Blocks.latest_block()
    end
  end

  describe "latest_block_transactions/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/blocks/latest/txs"

        response(
          200,
          [
            "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
            "4eef6bb7755d8afbeac526b799f3e32a624691d166657e9d862aaeb66682c036",
            "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
            "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b"
          ]
        )
      end)

      assert {:ok,
              [
                "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
                "4eef6bb7755d8afbeac526b799f3e32a624691d166657e9d862aaeb66682c036",
                "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
                "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b"
              ]} == Blocks.latest_block_transactions()
    end
  end

  describe "specific_block/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/blocks/4ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a"

        response(
          200,
          %{
            time: 1_641_338_934,
            height: 15_243_593,
            hash: "4ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a",
            slot: 412_162_133,
            epoch: 425,
            epoch_slot: 12,
            slot_leader: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2qnikdy",
            size: 3,
            tx_count: 1,
            output: "128314491794",
            fees: "592661",
            block_vrf: "vrf_vk1wf2k6lhujezqcfe00l6zetxpnmh9n6mwhpmhm0dvfh3fxgmdnrfqkms8ty",
            previous_block: "43ebccb3ac72c7cebd0d9b755a4b08412c9f5dcb81b8a0ad1e3c197d29d47b05",
            next_block: "8367f026cf4b03e116ff8ee5daf149b55ba5a6ec6dec04803b8dc317721d15fa",
            confirmations: 4698
          }
        )
      end)

      assert {:ok, @decoded_sample_block} ==
               Blocks.specific_block(
                 "4ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a"
               )
    end
  end

  describe "specific_block_in_slot/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/blocks/slot/30895909"

        response(200, @sample_block)
      end)

      assert {:ok, @decoded_sample_block} == Blocks.specific_block_in_slot(30_895_909)
    end
  end

  describe "specific_block_in_slot_in_epoch/2,3,4" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/blocks/epoch/219/slot/30895909"

        response(200, @sample_block)
      end)

      assert {:ok, @decoded_sample_block} ==
               Blocks.specific_block_in_slot_in_epoch(219, 30_895_909)
    end
  end

  describe "listing_of_next_blocks/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/blocks/1/next"

        response(200, [@sample_block])
      end)

      assert {:ok, [@decoded_sample_block]} == Blocks.listing_of_next_blocks("1")
    end
  end

  describe "listing_of_previous_blocks/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/blocks/2/previous"

        response(200, [@sample_block])
      end)

      assert {:ok, [@decoded_sample_block]} == Blocks.listing_of_previous_blocks("2")
    end
  end

  describe "block_transactions/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/blocks/1/txs"

        response(
          200,
          [
            "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
            "4eef6bb7755d8afbeac526b799f3e32a624691d166657e9d862aaeb66682c036",
            "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
            "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b"
          ]
        )
      end)

      assert {:ok,
              [
                "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
                "4eef6bb7755d8afbeac526b799f3e32a624691d166657e9d862aaeb66682c036",
                "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
                "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b"
              ]} == Blocks.block_transactions("1")
    end
  end
end
