defmodule Blockfrost.Response.AccountAssociatedAdressesResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Address do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:address)
    end
  end

  def cast(body) do
    Enum.map(body, &Address.cast/1)
  end
end
