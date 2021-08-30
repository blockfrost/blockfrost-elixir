defmodule Blockfrost.Response.CurrentBackendTimeResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{server_time: pos_integer()}

  embedded_schema do
    field(:server_time, :integer)
  end
end
