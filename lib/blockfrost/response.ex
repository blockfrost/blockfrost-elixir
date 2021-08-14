defmodule Blockfrost.Response do
  defmodule BaseSchema do
    defmacro __using__(_opts) do
      quote do
        use Ecto.Schema
        alias Ecto.Changeset

        @primary_key false

        def cast(body) do
          struct!(__MODULE__, [])
          |> Changeset.cast(body, __schema__(:fields))
          |> Changeset.apply_changes()
        end

        defoverridable(cast: 1)
      end
    end
  end

  def deserialize({:ok, %{body: body}}, module) do
    value =
      body
      |> Jason.decode!()
      |> module.cast()

    {:ok, value}
  end

  def deserialize({:ok, responses}, module) when is_list(responses) do
    value =
      responses
      |> Enum.map(&Jason.decode!(&1.body))
      |> List.flatten()
      |> module.cast()

    {:ok, value}
  end

  def deserialize(error, _module), do: error
end
