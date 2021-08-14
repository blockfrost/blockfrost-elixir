defmodule Blockfrost.Utils do
  @moduledoc false

  @spec extract_pagination(Keyword.t()) :: map
  def extract_pagination(opts) do
    opts
    |> Keyword.take([:page, :count, :order])
    |> Map.new()
  end
end
