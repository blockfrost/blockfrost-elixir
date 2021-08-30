defmodule Blockfrost.Response.TransactionMetadataContentJSONResponse do
  use Blockfrost.Response.BaseSchema

  defmodule TransactionMetadataContent do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:json_metadata, :any, virtual: true)
    end
  end

  @type t() :: [%TransactionMetadataContent{tx_hash: String.t(), json_metadata: term()}]

  @doc false
  def cast(body) do
    Enum.map(body, &TransactionMetadataContent.cast/1)
  end
end
