defmodule Blockfrost.Response.TransactionUTXOsResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          hash: String.t(),
          inputs: list(UTXOInput.t()),
          outputs: list(UTXOOutput.t())
        }

  defmodule UTXOInput do
    use Blockfrost.Response.BaseSchema

    @type t :: %__MODULE__{
            address: String.t(),
            amount: list(Blockfrost.Shared.Amount.t()),
            tx_hash: String.t(),
            output_index: integer(),
            data_hash: String.t(),
            collateral: boolean()
          }

    embedded_schema do
      field(:address, :string)
      embeds_many(:amount, Blockfrost.Shared.Amount)
      field(:tx_hash, :string)
      field(:output_index, :integer)
      field(:data_hash, :string)
      field(:collateral, :boolean)
    end
  end

  defmodule UTXOOutput do
    use Blockfrost.Response.BaseSchema

    defmodule AmountWithDataHash do
      use Blockfrost.Response.BaseSchema

      @type t :: %{
              unit: String.t(),
              quantity: String.t(),
              data_hash: String.t() | nil
            }

      embedded_schema do
        field(:unit, :string)
        field(:quantity, :string)
        field(:data_hash, :string)
      end
    end

    @type t :: %__MODULE__{
            address: String.t(),
            amount: list(AmountWithDataHash.t())
          }

    embedded_schema do
      field(:address, :string)
      embeds_many(:amount, AmountWithDataHash)
      field(:tx_hash, :string)
      field(:output_index, :integer)
      field(:data_hash, :string)
      field(:collateral, :boolean)
    end
  end

  embedded_schema do
    field(:hash, :string)
    embeds_many(:inputs, UTXOInput)
    embeds_many(:outputs, UTXOOutput)
  end
end
