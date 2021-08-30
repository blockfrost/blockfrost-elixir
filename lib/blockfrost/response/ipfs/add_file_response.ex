defmodule Blockfrost.Response.AddFileResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{name: String.t(), ipfs_hash: String.t(), size: integer()}

  embedded_schema do
    field(:name, :string)
    field(:ipfs_hash, :string)
    field(:size, :integer)
  end
end
