defmodule CanvasApp.Rectangle do
  use TypedStruct

  typedstruct enforce: true do
    field :width, pos_integer()
    field :height, pos_integer()
  end

  @spec new(map()) :: {:ok, __MODULE__.t()}
  def new(%{}), do: nil
end