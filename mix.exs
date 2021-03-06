defmodule CanvasApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :canvas_app,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      elixirc_options: [
        warnings_as_errors: true
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CanvasApp.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ~w(lib test/support)
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:typed_struct, "~> 0.2.1"},
      {:dialyxir, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.2"},
      {:elixir_uuid, "~> 1.2"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, ">= 0.0.0"},
      {:plug_cowboy, "~> 2.3"},
      {:mock, "~> 0.3.0", only: :test},
      {:git_hooks, "~> 0.5.0", only: [:test, :dev], runtime: false}
    ]
  end
end
