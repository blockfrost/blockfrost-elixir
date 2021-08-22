defmodule Blockfrost.Response.NetworkInformationResponse do
  use Blockfrost.Response.BaseSchema

  defmodule Supply do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:max, :string)
      field(:total, :string)
      field(:circulating, :string)
    end
  end

  defmodule Stake do
    use Blockfrost.Response.BaseSchema

    embedded_schema do
      field(:live, :string)
      field(:active, :string)
    end
  end

  embedded_schema do
    embeds_one(:supply, Supply)
    embeds_one(:stake, Stake)
  end
end
