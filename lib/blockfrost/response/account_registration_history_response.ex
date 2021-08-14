defmodule Blockfrost.Response.AccountRegistrationHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Registration do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:action, :string)
    end
  end

  def cast(body) do
    Enum.map(body, &Registration.cast/1)
  end
end
