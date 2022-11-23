# .credo.exs or config/.credo.exs
%{
  configs: [
    %{
      name: "default",
      checks: [
        {Credo.Check.Readability.ModuleDoc, false},
      ]
    }
  ]
}
