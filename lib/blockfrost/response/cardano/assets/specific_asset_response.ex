defmodule Blockfrost.Response.SpecificAssetResponse do
  use Blockfrost.Response.BaseSchema

  defmodule OnchainMetadata do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:name, :string)
      field(:image, :string)
    end
  end

  defmodule Metadata do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:name, :string)
      field(:description, :string)
      field(:ticker, :string)
      field(:url, :string)
      field(:logo, :string)
      field(:decimals, :integer)
    end
  end

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
