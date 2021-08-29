defmodule Blockfrost.IPFS.Pins do
  alias Blockfrost.HTTP
  alias Blockfrost.Utils

  alias Blockfrost.Response

  alias Blockfrost.Response.{
    PinObjectResponse,
    RemoveObjectPinResponse,
    ListPinnedObjectsResponse,
    SpecificPinnedObjectResponse
  }

  def pin_object(name, ipfs_path, opts \\ []) do
    name
    |> HTTP.build_and_send(:post, "/ipfs/pin/add/#{ipfs_path}", opts)
    |> Response.deserialize(PinObjectResponse)
  end

  def remove_object_pin(name, ipfs_path, opts \\ []) do
    name
    |> HTTP.build_and_send(:post, "/ipfs/pin/remove/#{ipfs_path}", opts)
    |> Response.deserialize(RemoveObjectPinResponse)
  end

  def list_pinned_objects(name, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/ipfs/pin/list/", opts)
    |> Response.deserialize(ListPinnedObjectsResponse)
  end

  def specific_pinned_object(name, ipfs_path, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/ipfs/pin/list/#{ipfs_path}", opts)
    |> Response.deserialize(SpecificPinnedObjectResponse)
  end
end
