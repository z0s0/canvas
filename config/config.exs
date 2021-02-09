import Config

config :canvas_app, ecto_repos: [CanvasApp.Repo]

config :canvas_app, CanvasApp.Repo,
  database: "canvas_app_dev",
  username: "postgres",
  password: "postgres",
  hostname: "db"

config :canvas_app, CanvasApp.API.Endpoint, [port: 5001]

if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end
