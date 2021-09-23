defmodule Blockfrost.Response.TransactionRedeemersResponse do
  defmodule Redeemer do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:tx_index, :integer)
      field(:purpose, Ecto.Enum, values: [:spend, :mint, :cert, :reward])
      field(:unit_mem, :string)
      field(:unit_steps, :string)
      field(:fee, :string)
    end
  end

  @type t :: [
          %Redeemer{
            tx_index: integer(),
            purpose: :spend | :mint | :cert | :reward,
            unit_mem: String.t(),
            unit_steps: String.t(),
            fee: String.t()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &Redeemer.cast/1)
  end
end
