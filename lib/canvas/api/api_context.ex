defmodule CanvasApp.API.ApiContext do
  @moduledoc """
    Exposes interface for HTTP layer(client)
    Transforms application layer structures to 'external-public' structures.
    External structures must be convenient for frontend application
  """

  alias CanvasApp.API.Layer
  alias CanvasApp.Model.API.Drawing

  def list_drawings() do
    [drawer, crud, matrix] = [
      Layer.drawer_module(),
      Layer.canvas_crud_module(),
      Layer.matrix_module()
    ]

    crud.list()
    |> Enum.map(fn canvas ->
      matrix = canvas |> drawer.draw() |> matrix.to_list_of_lists()
      Drawing.from_canvas(canvas, matrix)
    end)
  end
end
