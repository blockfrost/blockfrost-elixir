defmodule Blockfrost.Response.AddFileResponse do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:name, :string)
    field(:ipfs_hash, :string)
    field(:size, :integer)
  end
end
