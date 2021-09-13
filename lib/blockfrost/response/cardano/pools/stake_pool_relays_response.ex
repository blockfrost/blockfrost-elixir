defmodule Blockfrost.Response.StakePoolRelaysResponse do
  use Blockfrost.Response.BaseSchema

  defmodule StakePoolRelay do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:ipv4, :string)
      field(:ipv6, :string)
      field(:dns, :string)
      field(:dns_srv, :string)
      field(:port, :integer)
    end
  end

  @type t :: [
          %StakePoolRelay{
            ipv4: String.t(),
            ipv6: String.t(),
            dns: String.t(),
            dns_srv: String.t(),
            port: integer()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &StakePoolRelay.cast/1)
end
