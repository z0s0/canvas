defmodule CanvasApp.Core.DrawerTest do
  use ExUnit.Case

  alias CanvasApp.{Model, Core.Drawer, Matrix}
  alias Model.{Rectangle, Canvas, RectangleFactory}

  @fixture1 [
    "                         ",
    "                         ",
    "   @@@@@                 ",
    "   @XXX@  XXXXXXXXXXXXXX ",
    "   @@@@@  XOOOOOOOOOOOOX ",
    "          XOOOOOOOOOOOOX ",
    "          XOOOOOOOOOOOOX ",
    "          XOOOOOOOOOOOOX ",
    "          XXXXXXXXXXXXXX ",
    "                         "
  ]

  @fixture2 [
    "              ....... ",
    "              ....... ",
    "              ....... ",
    "OOOOOOOO      ....... ",
    "O      O      ....... ",
    "O    XXXXX    ....... ",
    "OOOOOXXXXX            ",
    "     XXXXX            ",
    "                      "
  ]

  @fixture3 [
    "              ....... ",
    "              ....... ",
    "              ....... ",
    "OOOOOOOO      ....... ",
    "O      O      ....... ",
    "O    XXXXX    ....... ",
    "OOOOOXXXXX            ",
    "     XXXXX            ",
    "                      "
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

      human_readable_canvas =
        canvas
        |> Drawer.draw()
        |> Matrix.to_list_of_lists()
        |> Enum.map(&Enum.join/1)

      assert human_readable_canvas == @fixture1
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

      human_readable_canvas =
        canvas
        |> Drawer.draw()
        |> Matrix.to_list_of_lists()
        |> Enum.map(&Enum.join/1)

      assert human_readable_canvas == @fixture2
    end
  end

  test "properly renders example 3" do
    # TODO support flood option

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

    human_readable_canvas =
      canvas
      |> Drawer.draw()
      |> Matrix.to_list_of_lists()
      |> Enum.map(&Enum.join/1)

    assert human_readable_canvas == @fixture3
  end
end
