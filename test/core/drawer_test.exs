defmodule CanvasApp.Core.DrawerTest do
  use ExUnit.Case

  alias CanvasApp.{Model, Core.Drawer, Matrix}
  alias Model.{Canvas, RectangleFactory}

  @fixture1 [
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

  @fixture2 [
    "              .......",
    "              .......",
    "              .......",
    "OOOOOOOO      .......",
    "O      O      .......",
    "O    XXXXX    .......",
    "OOOOOXXXXX           ",
    "     XXXXX           "
  ]

  @fixture3 [
    "--------------.......",
    "--------------.......",
    "--------------.......",
    "OOOOOOOO------.......",
    "O      O------.......",
    "O    XXXXX----.......",
    "OOOOOXXXXX-----------",
    "     XXXXX-----------"
  ]

  describe "draw/1 and simple examples" do
    test "renders example 1" do
      rectangle_params1 = %{
        width: 5,
        height: 3,
        coordinates: {3,2},
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

      assert draw_canvas_and_convert_to_human_readable(canvas) == @fixture1
    end

    test "renders example 2" do
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

      assert draw_canvas_and_convert_to_human_readable(canvas) == @fixture2
    end
  end

  test "properly renders example 3" do
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
    {:ok, canvas} = Canvas.new(%{rectangles: [rectangle1, rectangle2, rectangle3], flood: flood_params})

    assert draw_canvas_and_convert_to_human_readable(canvas) == @fixture3
  end

  @fixture [
    "    ",
    " 111",
    " 1@1",
    " 1@1",
    " 1@1",
    " 1@1",
    " 111"
  ]
  #rectangle filled not by fill parameter but with flood

  test "flood fills empty rectangle if start point is inside" do
    rectangle = RectangleFactory.build(%{width: 3, height: 6, coordinates: {1, 1}, outline_symbol: "1"})
    flood_params = %{start_coordinate: {2, 2}, fill_symbol: "@"}

    {:ok, canvas} = Canvas.new(%{rectangles: [rectangle], flood: flood_params})

    assert draw_canvas_and_convert_to_human_readable(canvas) == @fixture
  end

  @fixture [
    "!!!",
    "! !",
    "!!!"
  ]

  test "nothing should be changed if flood deployed to a cell occupied by rectangle" do
    rectangle = RectangleFactory.build(%{width: 3, height: 3, coordinates: {0, 0}, outline_symbol: "!"})
    flood_params = %{start_coordinate: {0, 1}, fill_symbol: "@"}

    {:ok, canvas} = Canvas.new(%{rectangles: [rectangle], flood: flood_params})

    assert draw_canvas_and_convert_to_human_readable(canvas) == @fixture
  end

  defp draw_canvas_and_convert_to_human_readable(canvas), do:
    canvas
    |> Drawer.draw()
    |> Matrix.to_list_of_lists()
    |> Enum.map(&Enum.join/1)
end
