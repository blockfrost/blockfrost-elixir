defmodule Blockfrost.Response do
  defmodule BaseSchema do
    defmacro __using__(_opts) do
      quote do
        use Ecto.Schema
        alias Ecto.Changeset

        @primary_key false

        def cast(body) do
          changeset =
            struct!(__MODULE__, [])
            |> Changeset.cast(body, __schema__(:fields) -- __schema__(:embeds))

          Enum.reduce(__schema__(:embeds), changeset, fn embed, changeset ->
            Changeset.cast_embed(changeset, embed,
              with: {__schema__(:embed, embed).related, :cast, []}
            )
          end)
          |> Changeset.apply_changes()
        end

        # this is called for embeds only
        def cast(_, body), do: body |> cast() |> Changeset.change()

        defoverridable(cast: 1, cast: 2)
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
