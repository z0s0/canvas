defmodule CanvasApp.Repo.Migrations.CreateCanvases do
  use Ecto.Migration

  def change do
    create table(:canvases, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :rectangles, {:array, :map}, null: false
      add :flood, :map

      timestamps()
    end
  end
end
