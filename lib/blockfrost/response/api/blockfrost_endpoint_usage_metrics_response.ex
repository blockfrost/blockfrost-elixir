defmodule Blockfrost.Response.BlockfrostEndpointUsageMetricsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Metric do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:time, :integer)
      field(:calls, :integer)
      field(:endpoint, :string)
    end
  end

  @type t :: [%Metric{time: pos_integer(), calls: non_neg_integer(), endpoint: String.t()}]

  @doc false
  def cast(body) do
    Enum.map(body, &Metric.cast/1)
  end
end
