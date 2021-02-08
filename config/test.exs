import Config

config :canvas_app, CanvasApp.Repo,
       pool: Ecto.Adapters.SQL.Sandbox,
       database: "canvas_app_test"
