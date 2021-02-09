defmodule CanvasApp.API.ApiContextTest do
  use ExUnit.Case

  import Mock

  alias CanvasApp.API.Layer
  alias CanvasApp.API.ApiContext, as: Service

  defmodule FakeMatrix do
    def to_list_of_lists(_), do: [["1", "1"], ["1", "1"]]
  end

  defmodule FakeDrawer do
    def draw(_),
      do: %{
        {0, 0} => "1",
        {0, 1} => "1",
        {1, 0} => "1",
        {1, 1} => "1"
      }
  end

  defmodule FakeCanvasCrud do
    def list(), do: [%{rectangles: [], flood: nil, id: 1}]
  end

  describe "list_drawings/0" do
    test "returns proper drawing" do
      with_mock Layer,
        drawer_module: fn -> FakeDrawer end,
        canvas_crud_module: fn -> FakeCanvasCrud end,
        matrix_module: fn -> FakeMatrix end do
        drawing = Service.list_drawings() |> hd()

        assert drawing.flood == nil
        assert drawing.id == 1
        assert drawing.matrix == FakeMatrix.to_list_of_lists(%{})
        assert drawing.rectangles == []
      end
    end
  end
end
