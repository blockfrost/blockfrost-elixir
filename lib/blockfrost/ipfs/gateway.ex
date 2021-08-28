defmodule Blockfrost.IPFS.Gateway do
  alias Blockfrost.HTTP

  def get(name \\ Blockfrost, ipfs_path, opts \\ []) do
    opts =
      opts
      |> Keyword.put_new(:retry_enabled?, false)
      |> Keyword.put_new(:skip_error_handling?, true)

    HTTP.build_and_send(name, :get, "/ipfs/gateway/#{ipfs_path}", %{}, %{}, nil, opts)
  end
end
