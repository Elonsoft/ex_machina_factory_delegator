defmodule ExMachinaFactoryDelegator.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_machina_factory_delegator,
      version: @version,
      elixir: ">= 1.4.0",
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
    [{:ex_machina, "~> 2.0"}]
  end
end
