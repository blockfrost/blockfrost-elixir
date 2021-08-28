defmodule Blockfrost.IPFS.PinsTest do
  use Blockfrost.Case

  alias Blockfrost.IPFS.Pins

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Shared.{
    ObjectPinInfo,
    PinnedObject
  }

  @sample_hash "QmPojRfAXYAXV92Dof7gtSgaVuxEk64xx9CKvprqu9VwA8"

  setup_all do
    start_supervised!({Blockfrost, name: IPFS, api_key: "apikey", network: :ipfs})
    :ok
  end

  describe "pin_object" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/pin/add/#{@sample_hash}"
        assert request.method == "POST"

        response(
          200,
          %{
            ipfs_hash: @sample_hash,
            state: "queued"
          }
        )
      end)

      assert {:ok,
              %ObjectPinInfo{
                ipfs_hash: @sample_hash,
                state: :queued
              }} == Pins.pin_object(IPFS, @sample_hash)
    end
  end

  describe "remove_object_pin" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/pin/remove/#{@sample_hash}"
        assert request.method == "POST"

        response(
          200,
          %{
            ipfs_hash: @sample_hash,
            state: "queued"
          }
        )
      end)

      assert {:ok,
              %ObjectPinInfo{
                ipfs_hash: @sample_hash,
                state: :queued
              }} == Pins.remove_object_pin(IPFS, @sample_hash)
    end
  end

  describe "list_pinned_objects" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/pin/list/"
        assert request.method == "GET"

        response(
          200,
          [
            %{
              time_created: 1_615_551_024,
              time_pinned: 1_615_551_024,
              ipfs_hash: @sample_hash,
              size: 1_615_551_024,
              state: "pinned"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %PinnedObject{
                  time_created: 1_615_551_024,
                  time_pinned: 1_615_551_024,
                  ipfs_hash: @sample_hash,
                  size: 1_615_551_024,
                  state: :pinned
                }
              ]} == Pins.list_pinned_objects(IPFS)
    end
  end

  describe "specific_pinned_object" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/pin/list/#{@sample_hash}"
        assert request.method == "GET"

        response(
          200,
          %{
            time_created: 1_615_551_024,
            time_pinned: 1_615_551_024,
            ipfs_hash: @sample_hash,
            size: 1_615_551_024,
            state: "pinned"
          }
        )
      end)

      assert {:ok,
              %PinnedObject{
                time_created: 1_615_551_024,
                time_pinned: 1_615_551_024,
                ipfs_hash: @sample_hash,
                size: 1_615_551_024,
                state: :pinned
              }} == Pins.specific_pinned_object(IPFS, @sample_hash)
    end
  end
end
