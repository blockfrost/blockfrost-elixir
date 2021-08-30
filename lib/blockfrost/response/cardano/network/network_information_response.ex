defmodule Blockfrost.Response.NetworkInformationResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Supply do
    use Blockfrost.Response.BaseSchema

    @type t :: %__MODULE__{max: String.t(), total: String.t(), circulating: String.t()}

    embedded_schema do
      field(:max, :string)
      field(:total, :string)
      field(:circulating, :string)
    end
  end

  defmodule Stake do
    use Blockfrost.Response.BaseSchema

    @type t :: %__MODULE__{live: String.t(), active: String.t()}

    embedded_schema do
      field(:live, :string)
      field(:active, :string)
    end
  end

  @type t :: %__MODULE__{supply: Supply.t(), stake: Stake.t()}

  embedded_schema do
    embeds_one(:supply, Supply)
    embeds_one(:stake, Stake)
  end
end
