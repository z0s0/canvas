defmodule CanvasApp.Migrator do
  @moduledoc """
    Module runs migrations for Repo.
    We run migrations when application starts for simplicity not because it is good.
  """

  def migrate() do
    path = "#{:code.priv_dir(:canvas_app)}/repo/migrations"
    Ecto.Migrator.run(CanvasApp.Repo, path, :up, all: true)
  end
end
