defmodule Blockfrost.Response.TransactionMIRsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule MIR do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:pot, Ecto.Enum, values: [:reserve, :treasury])
      field(:cert_index, :integer)
      field(:address, :string)
      field(:amount, :string)
    end
  end

  @type t :: [
          %MIR{
            pot: :reserve | :treasury,
            cert_index: integer(),
            address: String.t(),
            amount: String.t()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &MIR.cast/1)
  end
end
