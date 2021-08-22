defmodule Blockfrost.Response.AssetsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Asset do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:asset, :string)
      field(:quantity, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &Asset.cast/1)
  end
end
