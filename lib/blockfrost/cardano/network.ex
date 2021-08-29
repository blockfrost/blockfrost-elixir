defmodule Blockfrost.Cardano.Network do
  @moduledoc """

  """

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.NetworkInformationResponse

  @doc """
  """
  def network_info(name, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/network", opts)
    |> Response.deserialize(NetworkInformationResponse)
  end
end
