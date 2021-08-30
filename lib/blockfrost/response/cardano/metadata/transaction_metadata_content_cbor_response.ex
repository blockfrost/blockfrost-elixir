defmodule Blockfrost.Response.TransactionMetadataContentCBORResponse do
  use Blockfrost.Response.BaseSchema

  defmodule TransactionMetadataContent do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:cbor_metadata, :string)
    end
  end

  @type t() :: [%TransactionMetadataContent{tx_hash: String.t(), cbor_metadata: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &TransactionMetadataContent.cast/1)
  end
end
