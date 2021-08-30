defmodule Blockfrost.Response.AccountRegistrationHistoryResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Registration do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:action, :string)
    end
  end

  @type t :: [%Registration{tx_hash: String.t(), action: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &Registration.cast/1)
  end
end
