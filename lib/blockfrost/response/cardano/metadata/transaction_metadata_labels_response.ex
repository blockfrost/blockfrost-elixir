defmodule Blockfrost.Response.TransactionMetadataLabelsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule MetadataLabel do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:label, :string)
      field(:cip10, :string)
      field(:count, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &MetadataLabel.cast/1)
  end
end
