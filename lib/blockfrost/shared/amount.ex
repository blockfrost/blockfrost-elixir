defmodule Blockfrost.Shared.Amount do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:unit, :string)
    field(:quantity, :string)
  end
end
