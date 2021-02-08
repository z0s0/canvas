defmodule CanvasApp.PrepopulateSeeds do
  @moduledoc """
    It is easier to review a running application when there is something in DB. Of course it is not for production
    Prepopulated canvases are taken from app description
  """

  alias CanvasApp.Model.{Canvas}
  alias CanvasApp.Core.CanvasContext

  def perform() do
    if Enum.empty?(CanvasContext.list()) do
      [build_canvas1(), build_canvas2(), build_canvas3()]
      |> Enum.each(&CanvasContext.create/1)
    end
  end

  defp build_canvas1() do
    rectangle_params1 = %{
      width: 5,
      height: 3,
      coordinates: [3,2], #list because we simulate params received from frontend
      outline_symbol: "@",
      fill_symbol: "X"
    }

    rectangle_params2 = %{
      width: 14,
      height: 6,
      coordinates: [10, 3],
      outline_symbol: "X",
      fill_symbol: "O"
    }

    %{rectangles: [rectangle_params1, rectangle_params2]}
  end

  defp build_canvas2() do
    rectangle_params1 = %{
      coordinates: [14, 0],
      width: 7,
      height: 6,
      outline_symbol: nil,
      fill_symbol: "."
    }
    rectangle_params2 = %{
      coordinates: [0, 3],
      width: 8,
      height: 4,
      outline_symbol: "O",
      fill_symbol: nil
    }
    rectangle_params3 = %{
      coordinates: [5, 5],
      width: 5,
      height: 3,
      outline_symbol: "X",
      fill_symbol: "X"
    }

    %{rectangles: [rectangle_params1, rectangle_params2, rectangle_params3]}
  end

  def build_canvas3() do
    rectangle_params1 = %{
      coordinates: [14, 0],
      width: 7,
      height: 6,
      outline_symbol: nil,
      fill_symbol: "."
    }
    rectangle_params2 = %{
      coordinates: [0, 3],
      width: 8,
      height: 4,
      outline_symbol: "O",
      fill_symbol: nil
    }
    rectangle_params3 = %{
      coordinates: [5, 5],
      width: 5,
      height: 3,
      outline_symbol: "X",
      fill_symbol: "X"
    }

    flood_params = %{fill_symbol: "-", start_coordinate: [0, 0]}

    %{
      rectangles: [rectangle_params1, rectangle_params2, rectangle_params3],
      flood: flood_params
    }
  end
end
