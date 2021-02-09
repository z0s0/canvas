defmodule CanvasApp.Model.API.Drawing do
  @moduledoc """
    API objects— external objects. The only objects exposed, the only objects with JSON codecs defined
  """
  use TypedStruct

  @type rectangle_definition() :: %{
          required(:width) => non_neg_integer(),
          required(:height) => non_neg_integer(),
          required(:coordinates) => list(non_neg_integer()),
          optional(:fillSymbol) => String.t(),
          optional(:outlineSymbol) => String.t()
        }
  @type matrix() :: [[String.t()]]
  @type flood() :: %{
          required(:startCoordinate) => list(non_neg_integer()),
          required(:fillSymbol) => String.t()
        }

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, CanvasApp.UUID.t())
    field(:matrix, [[String.t()]])
    field(:flood, flood() | nil)
    field(:rectangles, [rectangle_definition()])
  end

  # Matrix must not be calculated here so we accept it in constructor
  def from_canvas(canvas, matrix) do
    rectangles = Enum.map(canvas.rectangles, &transform_rectangle/1)
    flood = transform_flood(canvas.flood)

    %{rectangles: rectangles, flood: flood, matrix: matrix, id: canvas.id}
  end

  defp transform_rectangle(%{
         width: width,
         height: height,
         coordinates: {x, y},
         outline_symbol: outline_symbol,
         fill_symbol: fill_symbol
       }) do
    # convert symbols back to definition
    outline_symbol_was =
      if outline_symbol == fill_symbol do
        nil
      else
        outline_symbol
      end

    fill_symbol_was =
      if fill_symbol == " " do
        nil
      else
        fill_symbol
      end

    %{
      width: width,
      height: height,
      coordinates: [x, y],
      outlineSymbol: outline_symbol_was,
      fillSymbol: fill_symbol_was
    }
  end

  defp transform_flood(nil), do: nil

  defp transform_flood(%{start_coordinate: {x, y}, fill_symbol: fill}) do
    %{startCoordinate: [x, y], fillSymbol: fill}
  end
end
