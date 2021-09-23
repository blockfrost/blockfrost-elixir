defmodule Blockfrost.Response.TransactionMetadataResponse do
  defmodule Metadata do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:label, :string)
      field(:json_metadata, :map)
    end
  end

  @type t :: [
          %Metadata{
            label: String.t(),
            json_metadata: term()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &Metadata.cast/1)
  end
end
