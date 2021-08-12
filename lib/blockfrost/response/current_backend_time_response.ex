defmodule Blockfrost.Response.CurrentBackendTimeResponse do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:server_time, :integer)
  end
end
