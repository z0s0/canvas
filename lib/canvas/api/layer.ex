defmodule CanvasApp.API.Layer do
  @module """
    Layer— the only point service can take dependencies from.
    It simplifies dependency injection and prevents developers to make awkward imports
  """

  def drawer_module(), do: CanvasApp.Core.Drawer
  def canvas_crud_module(), do: CanvasApp.Core.CanvasContext
  def matrix_module(), do: CanvasApp.Matrix
end
