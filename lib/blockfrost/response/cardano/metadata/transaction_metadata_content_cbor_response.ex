defmodule Blockfrost.Response.TransactionMetadataContentCBORResponse do
  use Blockfrost.Response.BaseSchema

  defmodule TransactionMetadataContent do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:cbor_metadata, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &TransactionMetadataContent.cast/1)
  end
end
