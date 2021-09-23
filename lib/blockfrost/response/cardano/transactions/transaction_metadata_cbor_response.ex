defmodule Blockfrost.Response.TransactionMetadataCBORResponse do
  defmodule MetadataCBOR do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:label, :string)
      field(:cbor_metadata, :string)
    end
  end

  @type t :: [
          %MetadataCBOR{
            label: String.t(),
            cbor_metadata: String.t()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &MetadataCBOR.cast/1)
  end
end
