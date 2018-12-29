defmodule ScenicDriverGPIO.MixProject do
  use Mix.Project

  def project do
    [
      app: :scenic_driver_gpio,
      version: "0.1.0",
      elixir: "~> 1.7",
      description: description(),
      package: package(),
      source_url: "https://github.com/mobileoverlord/scenic_driver_gpio",
      docs: [extras: ["README.md"], main: "readme"],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application, do: []

  defp description do
    "Send GPIO events to Scenic"
  end

  defp package do
    %{
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/mobileoverlord/scenic_driver_gpio"}
    }
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:circuits_gpio, github: "elixir-circuits/circuits_gpio"},
      {:scenic, "~> 0.9"},
      {:ex_doc, "~> 0.11", only: :dev, runtime: false}
    ]
  end
end
