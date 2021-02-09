defmodule CanvasApp.API.ApiContext do
  @moduledoc """
    Exposes interface for HTTP layer(client)
    Transforms application layer structures to 'external-public' structures.
    External structures must be convenient for frontend application
  """

  alias CanvasApp.Core.{Drawer, CanvasContext}
  alias CanvasApp.Matrix
  alias CanvasApp.Model.API.Drawing

  def list_drawings() do
    CanvasContext.list()
    |> Enum.map(fn canvas ->
      matrix = canvas |> Drawer.draw() |> Matrix.to_list_of_lists()
      Drawing.from_canvas(canvas, matrix)
    end)
  end
end
