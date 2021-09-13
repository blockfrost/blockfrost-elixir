defmodule Blockfrost.Response.ListOfRetiredStakePoolsResponse do
  defmodule RetiredStakePool do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:pool_id, :string)
      field(:epoch, :integer)
    end
  end

  @type t :: [
          %RetiredStakePool{
            pool_id: String.t(),
            epoch: integer()
          }
        ]

  @doc false
  def cast(body), do: Enum.map(body, &RetiredStakePool.cast/1)
end
