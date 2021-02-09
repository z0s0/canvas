defmodule CanvasApp.Core.DrawerTest do
  use ExUnit.Case

  alias CanvasApp.{Model, Core.Drawer, Matrix, Fixtures}
  alias Model.{Canvas, RectangleFactory}

  describe "draw/1 and simple examples" do
    test "renders example 1" do
      canvas = Fixtures.canvas_for_fixture1()

      assert draw_canvas_and_convert_to_human_readable(canvas) == Fixtures.fixture1()
    end

    test "renders example 2" do
      canvas = Fixtures.canvas_for_fixture2()

      assert draw_canvas_and_convert_to_human_readable(canvas) == Fixtures.fixture2()
    end
  end

  test "properly renders example 3" do
    canvas = Fixtures.canvas_for_fixture3()

    assert draw_canvas_and_convert_to_human_readable(canvas) == Fixtures.fixture3()
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
    "@@@",
    "@ @",
    "@@@"
  ]

  test "all rectangle edge symbols to be replaced if flood start_point targets to rectangle's point" do
    #all ! replaced by @
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
