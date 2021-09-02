defmodule Blockfrost.IPFS.Gateway do
  alias Blockfrost.HTTP
  alias Blockfrost.Utils

  def get(name, ipfs_path, opts \\ []) do
    Utils.validate_ipfs!(name)

    opts =
      opts
      |> Keyword.put_new(:retry_enabled?, false)
      |> Keyword.put_new(:skip_error_handling?, true)

    HTTP.build_and_send(name, :get, "/ipfs/gateway/#{ipfs_path}", opts)
  end
end
