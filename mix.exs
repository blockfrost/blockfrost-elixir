defmodule Blockfrost.MixProject do
  use Mix.Project

  def project do
    [
      app: :blockfrost,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      # Package
      description: "SDK for the blockfrost.io API",
      package: [
        name: "blockfrost",
        licenses: ["Apache-2.0"],
        links: %{"GitHub" => "https://github.com/blockfrost/blockfrost-elixir"}
      ],
      # Docs
      name: "Blockfrost",
      source_url: "https://github.com/blockfrost/blockfrost-elixir",
      homepage_url: "blockfrost.io",
      docs: [
        logo: "./logo.png",
        extras: ["README.md"],
        nest_modules_by_prefix: [
          Blockfrost.API,
          Blockfrost.Cardano,
          Blockfrost.IPFS,
          Blockfrost.Response,
          Blockfrost.Shared
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:ecto, "~> 3.6"},
      {:multipart, "~> 0.2.0"},
      {:finch, "~> 0.8.0"},
      {:credo, "~> 1.5", only: :dev},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:mox, "~> 1.0", only: [:test]},
      {:ex_doc, "~> 0.25", only: [:docs]}
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]
end
