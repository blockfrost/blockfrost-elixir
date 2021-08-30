defmodule Blockfrost.Shared.Amount do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{unit: String.t(), quantity: String.t()}

  embedded_schema do
    field(:unit, :string)
    field(:quantity, :string)
  end
end
