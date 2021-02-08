import Config

config :canvas_app, ecto_repos: [CanvasApp.Repo]

config :canvas_app, CanvasApp.Repo,
  database: "canvas_app_dev",
  username: "postgres"

if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end
