import Config

config :canvas_app, ecto_repos: [CanvasApp.Repo]

config :canvas_app, CanvasApp.Repo,
  database: "canvas_app_dev",
  username: "postgres",
  password: "postgres",
  hostname: "db"

config :canvas_app, CanvasApp.API.Endpoint, port: 5000

config :canvas_app, populate_seeds?: true

if Mix.env() == :dev do
  config :git_hooks,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          "mix format --check-formatted"
        ]
      ]
    ]
end

if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end
