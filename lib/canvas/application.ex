defmodule CanvasApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      CanvasApp.Repo
    ]

    opts = [strategy: :one_for_one, name: CanvasApp.Supervisor]
    ok_pid = Supervisor.start_link(children, opts)

    CanvasApp.Migrator.migrate()
    #CanvasApp.PrepopulateSeeds.perform()

    ok_pid
  end
end
