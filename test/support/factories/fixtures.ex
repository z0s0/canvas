defmodule CanvasApp.Fixtures do
  @moduledoc """
    fixtures from test task description
  """

  def fixture1() do
    [
      "                        ",
      "                        ",
      "   @@@@@                ",
      "   @XXX@  XXXXXXXXXXXXXX",
      "   @@@@@  XOOOOOOOOOOOOX",
      "          XOOOOOOOOOOOOX",
      "          XOOOOOOOOOOOOX",
      "          XOOOOOOOOOOOOX",
      "          XXXXXXXXXXXXXX"
    ]
  end

  def fixture2() do
    [
      "              .......",
      "              .......",
      "              .......",
      "OOOOOOOO      .......",
      "O      O      .......",
      "O    XXXXX    .......",
      "OOOOOXXXXX           ",
      "     XXXXX           "
    ]
  end

  def fixture3() do
    [
      "--------------.......",
      "--------------.......",
      "--------------.......",
      "OOOOOOOO------.......",
      "O      O------.......",
      "O    XXXXX----.......",
      "OOOOOXXXXX-----------",
      "     XXXXX-----------"
    ]
  end

  alias CanvasApp.Model.{RectangleFactory, Canvas}

  def params_for_fixture1_canvas() do
    rectangle_params1 = %{
      width: 5,
      height: 3,
      coordinates: [3, 2],
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

  def params_for_fixture2_canvas() do
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

  def params_for_fixture3_canvas() do
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

  def canvas_for_fixture1() do
    rectangle_params1 = %{
      width: 5,
      height: 3,
      coordinates: {3, 2},
      outline_symbol: "@",
      fill_symbol: "X"
    }

    rectangle1 = RectangleFactory.build(rectangle_params1)

    rectangle_params2 = %{
      width: 14,
      height: 6,
      coordinates: {10, 3},
      outline_symbol: "X",
      fill_symbol: "O"
    }

    rectangle2 = RectangleFactory.build(rectangle_params2)

    {:ok, canvas} = Canvas.new(%{rectangles: [rectangle1, rectangle2]})

    canvas
  end

  def canvas_for_fixture2() do
    rectangle_params1 = %{
      coordinates: {14, 0},
      width: 7,
      height: 6,
      outline_symbol: nil,
      fill_symbol: "."
    }

    rectangle_params2 = %{
      coordinates: {0, 3},
      width: 8,
      height: 4,
      outline_symbol: "O",
      fill_symbol: nil
    }

    rectangle_params3 = %{
      coordinates: {5, 5},
      width: 5,
      height: 3,
      outline_symbol: "X",
      fill_symbol: "X"
    }

    rectangle1 = RectangleFactory.build(rectangle_params1)
    rectangle2 = RectangleFactory.build(rectangle_params2)
    rectangle3 = RectangleFactory.build(rectangle_params3)

    {:ok, canvas} = Canvas.new(%{rectangles: [rectangle1, rectangle2, rectangle3]})

    canvas
  end

  def canvas_for_fixture3() do
    rectangle_params1 = %{
      coordinates: {14, 0},
      width: 7,
      height: 6,
      outline_symbol: nil,
      fill_symbol: "."
    }

    rectangle_params2 = %{
      coordinates: {0, 3},
      width: 8,
      height: 4,
      outline_symbol: "O",
      fill_symbol: nil
    }

    rectangle_params3 = %{
      coordinates: {5, 5},
      width: 5,
      height: 3,
      outline_symbol: "X",
      fill_symbol: "X"
    }

    rectangle1 = RectangleFactory.build(rectangle_params1)
    rectangle2 = RectangleFactory.build(rectangle_params2)
    rectangle3 = RectangleFactory.build(rectangle_params3)
    flood_params = %{fill_symbol: "-", start_coordinate: {0, 0}}

    {:ok, canvas} =
      Canvas.new(%{rectangles: [rectangle1, rectangle2, rectangle3], flood: flood_params})

    canvas
  end
end
