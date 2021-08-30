defmodule Blockfrost.Response.SpecificAssetResponse do
  use Blockfrost.Response.BaseSchema

  defmodule OnchainMetadata do
    use Blockfrost.Response.BaseSchema

    @type t :: %__MODULE__{
            name: String.t(),
            image: String.t()
          }

    embedded_schema do
      field(:name, :string)
      field(:image, :string)
    end
  end

  defmodule Metadata do
    use Blockfrost.Response.BaseSchema

    @type t :: %__MODULE__{
            name: String.t(),
            description: String.t(),
            ticker: String.t() | nil,
            url: String.t() | nil,
            logo: String.t() | nil,
            decimals: integer() | nil
          }

    embedded_schema do
      field(:name, :string)
      field(:description, :string)
      field(:ticker, :string)
      field(:url, :string)
      field(:logo, :string)
      field(:decimals, :integer)
    end
  end

  @type t :: %__MODULE__{
          asset: String.t(),
          policy_id: String.t(),
          asset_name: String.t() | nil,
          fingerprint: String.t(),
          quantity: String.t(),
          initial_mint_tx_hash: String.t(),
          mint_or_burn_count: String.t(),
          onchain_metadata: OnchainMetadata.t() | nil,
          metadata: Metadata.t() | nil
        }

  embedded_schema do
    field(:asset, :string)
    field(:policy_id, :string)
    field(:asset_name, :string)
    field(:fingerprint, :string)
    field(:quantity, :string)
    field(:initial_mint_tx_hash, :string)
    field(:mint_or_burn_count, :integer)
    embeds_one(:onchain_metadata, OnchainMetadata)
    embeds_one(:metadata, Metadata)
  end
end
