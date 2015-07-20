defmodule Expand.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :expand,
      name: "Expand",
      version: @version,
      description: "A pretty printer",
      elixir: "~> 1.0",
      package: package,
      deps: deps,
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp package do
    %{
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/joeyates/expand"},
    }
  end

  defp deps do
    [
    ]
  end
end