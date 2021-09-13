defmodule Blockfrost.Response.StakePoolUpdatesResponse do
  use Blockfrost.Response.BaseSchema

  defmodule StakePoolUpdate do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_hash, :string)
      field(:cert_index, :integer)
      field(:action, :string)
    end
  end

  @type t :: [
          %StakePoolUpdate{
            tx_hash: String.t(),
            cert_index: integer(),
            action: String.t()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &StakePoolUpdate.cast/1)
end
