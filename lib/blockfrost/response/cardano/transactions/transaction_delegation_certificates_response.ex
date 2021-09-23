defmodule Blockfrost.Response.TransactionDelegationCertificatesResponse do
  defmodule DelegationCertificate do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:index, :integer)
      field(:cert_index, :integer)
      field(:address, :string)
      field(:pool_id, :string)
      field(:active_epoch, :integer)
    end
  end

  @type t :: [
          %DelegationCertificate{
            index: integer(),
            cert_index: integer(),
            address: String.t(),
            pool_id: String.t(),
            active_epoch: integer()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &DelegationCertificate.cast/1)
end
