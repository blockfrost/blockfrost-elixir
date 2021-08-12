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

  def cast(body) do
    Enum.map(body, &Metric.cast/1)
  end
end
