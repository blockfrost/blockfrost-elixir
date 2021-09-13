defmodule Blockfrost.Response.ListOfRetiringStakePoolsResponse do
  defmodule RetiringStakePool do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:pool_id, :string)
      field(:epoch, :integer)
    end
  end

  @type t :: [
          %RetiringStakePool{
            pool_id: String.t(),
            epoch: integer()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &RetiringStakePool.cast/1)
end
