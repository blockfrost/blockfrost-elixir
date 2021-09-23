defmodule Blockfrost.Response.TransactionStakePoolRetirementCertificatesResponse do
  defmodule Certificate do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:cert_index, :integer)
      field(:pool_id, :string)
      field(:retiring_epoch, :integer)
    end
  end

  @type t :: [
          %Certificate{
            cert_index: integer(),
            pool_id: String.t(),
            retiring_epoch: integer()
          }
        ]

  @doc false
  def cast(body) do
    Enum.map(body, &Certificate.cast/1)
  end
end
