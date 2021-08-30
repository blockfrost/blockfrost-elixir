defmodule Blockfrost.Response.BackendHealthStatusResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{is_healthy: boolean()}

  embedded_schema do
    field(:is_healthy, :boolean)
  end
end
