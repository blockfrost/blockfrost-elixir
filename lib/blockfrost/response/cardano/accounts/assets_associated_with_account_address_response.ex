defmodule Blockfrost.Response.AssetsAssociatedWithAccountAddressResponse do
  use Blockfrost.Response.BaseSchema

  defmodule AssetAssociatedWithAccountAddress do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:unit, :string)
      field(:quantity, :string)
    end
  end

  @type t :: [%AssetAssociatedWithAccountAddress{unit: String.t(), quantity: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &AssetAssociatedWithAccountAddress.cast/1)
  end
end
