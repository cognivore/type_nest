defmodule Etypes.MixProject do
  use Mix.Project

  def project do
    [
      app: :etypes,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:dialyxir, github: "jeremyjh/dialyxir", branch: "master", only: :dev, runtime: false},
      # Use algae and see how it works with dialyzer.
      # We get it from github: https://github.com/doma-engineering/algae-goo.git
      {:algae_goo, github: "doma-engineering/algae-goo", branch: "main"}
    ]
  end
end
