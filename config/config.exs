import Config

config :canvas_app, ecto_repos: [CanvasApp.Repo]

config :canvas_app, CanvasApp.Repo,
  database: "canvas_app_dev",
  username: "postgres"