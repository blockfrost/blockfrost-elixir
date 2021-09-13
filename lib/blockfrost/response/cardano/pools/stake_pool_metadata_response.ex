defmodule Blockfrost.Response.StakePoolMetadataResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: [
          %__MODULE__{
            pool_id: String.t(),
            hex: String.t(),
            url: String.t(),
            hash: String.t(),
            ticker: String.t(),
            name: String.t(),
            description: String.t(),
            homepage: String.t()
          }
        ]

  embedded_schema do
    field(:pool_id, :string)
    field(:hex, :string)
    field(:url, :string)
    field(:hash, :string)
    field(:ticker, :string)
    field(:name, :string)
    field(:description, :string)
    field(:homepage, :string)
  end
end
