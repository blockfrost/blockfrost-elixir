defmodule Blockfrost.Cardano.Network do
  @moduledoc "Functions for to the /network namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.NetworkInformationResponse

  @doc """
  Return detailed network information.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Network/paths/~1network/get)
  """
  @spec network_info(Blockfrost.t(), Keyword.t()) ::
          {:ok, NetworkInformationResponse.t()} | HTTP.error_response()
  def network_info(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/network", opts)
    |> Response.deserialize(NetworkInformationResponse)
  end
end
