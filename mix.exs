defmodule Toks.MixProject do
  use Mix.Project

  def project do
    [
      app: :toks,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: """
      Vonage (TokBox) API Client
      """
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Toks.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:hackney, "~> 1.16.0"},
      {:jason, ">= 1.0.0"},
      {:joken, "~> 2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: [
        "Chris Freeze"
      ],
      licenses: ["MIT"],
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      links: %{"GitHub" => "https://github.com/cjfreeze/toks"}
    ]
  end
end
