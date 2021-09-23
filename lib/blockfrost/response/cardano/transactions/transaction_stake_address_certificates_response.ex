defmodule Blockfrost.Response.TransactionStakeAddressCertificatesResponse do
  defmodule StakeAddressCertificate do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:cert_index, :integer)
      field(:address, :string)
      field(:registration, :boolean)
    end
  end

  @type t :: [
          %StakeAddressCertificate{
            cert_index: integer(),
            address: String.t(),
            registration: boolean()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &StakeAddressCertificate.cast/1)
end
