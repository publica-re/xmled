defmodule Xmled.MixProject do
  use Mix.Project

  def project do
    [
      app: :xmled,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {CLI, ["plants.xml"]},
      extra_applications: [:logger, :xmerl, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nanoid, "~> 2.0.4"},
      {:nimble_parsec, "~> 1.1.0"},
      {:combine, "~> 0.10.0"}
    ]
  end

  defp escript do
    [main_module: CLI]
  end
end
