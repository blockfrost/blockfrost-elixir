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

  @doc """
  Pinned objects are counted in your user storage quota.

  [API Docs](https://docs.blockfrost.io/#tag/IPFS-Pins/paths/~1ipfs~1pin~1add~1{IPFS_path}/post)
  """
  @spec pin_object(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, PinObjectResponse.t()} | HTTP.error_response()
  def pin_object(name, ipfs_path, opts \\ []) do
    name
    |> HTTP.build_and_send(:post, "/ipfs/pin/add/#{ipfs_path}", opts)
    |> Response.deserialize(PinObjectResponse)
  end

  @doc """
  Remove pinned objects from local storage

  [API Docs](https://docs.blockfrost.io/#tag/IPFS-Pins/paths/~1ipfs~1pin~1remove~1{IPFS_path}/post)
  """
  @spec remove_object_pin(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, RemoveObjectPinResponse.t()} | HTTP.error_response()
  def remove_object_pin(name, ipfs_path, opts \\ []) do
    name
    |> HTTP.build_and_send(:post, "/ipfs/pin/remove/#{ipfs_path}", opts)
    |> Response.deserialize(RemoveObjectPinResponse)
  end

  @doc """
  List objects pinned to local storage.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/IPFS-Pins/paths/~1ipfs~1pin~1list~1/get)
  """
  @spec list_pinned_objects(Blockfrost.t(), Keyword.t()) ::
          {:ok, ListPinnedObjectsResponse.t()} | HTTP.error_response()
  def list_pinned_objects(name, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/ipfs/pin/list/", opts)
    |> Response.deserialize(ListPinnedObjectsResponse)
  end

  @doc """
  Get details about a specific pinned objet

  [API Docs](https://docs.blockfrost.io/#tag/IPFS-Pins/paths/~1ipfs~1pin~1list~1{IPFS_path}/get)
  """
  @spec specific_pinned_object(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificPinnedObjectResponse.t()} | HTTP.error_response()
  def specific_pinned_object(name, ipfs_path, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/ipfs/pin/list/#{ipfs_path}", opts)
    |> Response.deserialize(SpecificPinnedObjectResponse)
  end
end
