import Config

config :canvas_app, CanvasApp.Repo,
       pool: Ecto.Adapters.SQL.Sandbox,
       database: "canvas_app_test",
       hostname: "localhost"

config :canvas_app, populate_seeds?: false
