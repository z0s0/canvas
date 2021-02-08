defmodule CanvasApp.Model.RectangleFactory do
  alias CanvasApp.Model.Rectangle

  @doc """
    always returns valid rectangle
  """
  def build() do
    arbitrary_params = %{
      width: Enum.random(1..10),
      height: Enum.random(1..10),
      coordinates: {Enum.random(1..5), Enum.random(1..5)},
      outline_symbol: Enum.random(~w(| @ . & -)),
      fill_symbol: Enum.random(~W(| @ . & =))
    }

    {:ok, rectangle} = Rectangle.new(arbitrary_params)
    rectangle
  end

  def build(params), do: params |> Rectangle.new() |> elem(1)
end
