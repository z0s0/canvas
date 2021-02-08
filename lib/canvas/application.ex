defmodule CanvasApp.Application do
  use Application

  def start(_type, _args) do
    api_endpoint = CanvasApp.API.Endpoint
    children = [
      CanvasApp.Repo,
      {Plug.Cowboy, scheme: :http, plug: api_endpoint, options: Application.get_env(:canvas_app, api_endpoint)}
    ]

    opts = [strategy: :one_for_one, name: CanvasApp.Supervisor]
    ok_pid = Supervisor.start_link(children, opts)

    CanvasApp.Migrator.migrate()
    #CanvasApp.PrepopulateSeeds.perform()

    ok_pid
  end
end
