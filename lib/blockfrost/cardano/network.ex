defmodule Blockfrost.Cardano.Network do
  @moduledoc """

  """

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.NetworkInformationResponse

  @doc """
  """
  def network_info(name \\ Blockfrost, opts \\ []) do
    name
    |> HTTP.build_and_send(:get, "/network", %{}, %{}, nil, opts)
    |> Response.deserialize(NetworkInformationResponse)
  end
end
