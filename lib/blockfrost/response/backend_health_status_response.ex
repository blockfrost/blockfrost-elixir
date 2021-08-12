defmodule Blockfrost.Response.BackendHealthStatusResponse do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:is_healthy, :boolean)
  end
end
