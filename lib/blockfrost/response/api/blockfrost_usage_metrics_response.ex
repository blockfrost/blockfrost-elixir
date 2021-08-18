defmodule Blockfrost.Response.BlockfrostUsageMetricsResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Metric do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:time, :integer)
      field(:calls, :integer)
    end
  end

  def cast(body) do
    Enum.map(body, &Metric.cast/1)
  end
end
