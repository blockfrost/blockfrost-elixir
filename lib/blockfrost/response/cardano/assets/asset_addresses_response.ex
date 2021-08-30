defmodule Blockfrost.Response.AssetAddressesResponse do
  use Blockfrost.Response.BaseSchema

  defmodule AssetAddress do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:address, :string)
      field(:quantity, :string)
    end
  end

  @type t :: [%AssetAddress{address: String.t(), quantity: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &AssetAddress.cast/1)
  end
end
