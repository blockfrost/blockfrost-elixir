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

  @type t() :: [%MetadataLabel{label: String.t(), cip10: String.t(), count: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &MetadataLabel.cast/1)
  end
end
