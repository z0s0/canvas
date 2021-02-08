defmodule CanvasApp.DatabaseCase do
  use ExUnit.CaseTemplate

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(CanvasApp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(CanvasApp.Repo, {:shared, self()})
    end

    :ok
  end
end
