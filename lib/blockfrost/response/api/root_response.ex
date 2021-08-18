defmodule Blockfrost.Response.RootResponse do
  use Blockfrost.Response.BaseSchema

  embedded_schema do
    field(:url, :string)
    field(:version, :string)
  end
end
