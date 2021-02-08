defmodule CanvasApp.API.ApiContext do
  @moduledoc """
    Exposes interface for HTTP layer(client)
    Transforms application layer structures to 'external-public' structures.
    External structures must be convenient for frontend application
  """

  alias CanvasApp.Core.Drawer

  def list_canvases() do
    []
  end

  def get_canvas(canvas_id) do

  end
end
