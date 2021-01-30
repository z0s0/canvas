defmodule CanvasApp.Canvas do
  use TypedStruct

  typedstruct enforce: true do
    field :id, CanvasApp.UUID.t()
    field :rectangles, [CanvasApp.Rectangle.t()], default: []
  end

  @spec new(map()) :: {:ok, __MODULE__.t()}
  def new(%{rectangles: rectangles}) do

  end
end