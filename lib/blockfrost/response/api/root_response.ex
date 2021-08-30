defmodule Blockfrost.Response.RootResponse do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          url: String.t(),
          version: String.t()
        }

  embedded_schema do
    field(:url, :string)
    field(:version, :string)
  end
end
