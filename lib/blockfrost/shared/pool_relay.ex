defmodule Blockfrost.Shared.StakePoolRelay do
  use Blockfrost.Response.BaseSchema

  @type t :: %__MODULE__{
          ipv4: String.t() | nil,
          ipv6: String.t() | nil,
          dns: String.t() | nil,
          dns_srv: String.t() | nil,
          port: integer()
        }

  embedded_schema do
    field(:ipv4, :string)
    field(:ipv6, :string)
    field(:dns, :string)
    field(:dns_srv, :string)
    field(:port, :integer)
  end
end
