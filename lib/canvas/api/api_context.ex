defmodule CanvasApp.API.ApiContext do
  @moduledoc """
    Exposes interface for HTTP layer(client)
    Transforms application layer structures to 'external-public' structures.
    External structures must be convenient for frontend application
  """

  alias CanvasApp.Core.{Drawer, CanvasContext}
  alias CanvasApp.Matrix

  def list_canvases() do
    CanvasContext.list()
    |> Enum.map(fn canvas ->
      canvas
      |> Drawer.draw()
      |> Matrix.to_list_of_lists()
    end)
  end
end
