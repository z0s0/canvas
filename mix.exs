defmodule CanvasApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :canvas_app,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CanvasApp.Application, []}
    ]
  end

  defp deps do
    [
      {:typed_struct, "~> 0.2.1"},
      {:dialyxir, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.2"},
      {:elixir_uuid, "~> 1.2"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, ">= 0.0.0"},
      {:plug_cowboy, "~> 2.3"}
    ]
  end
end
