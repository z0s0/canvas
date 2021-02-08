defmodule CanvasApp.Core.CanvasContextTest do
  use CanvasApp.DatabaseCase

  alias CanvasApp.Core.CanvasContext, as: Service
  alias CanvasApp.Core.Drawer
  alias CanvasApp.Fixtures
  alias CanvasApp.Core.Error.{NotFound, ValidationError}
  alias CanvasApp.Model.{Canvas, Rectangle, Flood}

  @valid_rectangle_params %{width: 1, height: 1, coordinates: [1,2], outline_symbol: "@"}

  describe "list/0" do
    test "returns empty list when no canvases persisted" do
      assert Service.list() == []
    end

    test "returns list of Canvas.t()" do
      CanvasApp.PrepopulateSeeds.perform()
      result = Service.list()

      assert Enum.all?(result, & match?(%Canvas{}, &1))
    end
  end

  describe "get_by_id/1" do
    test "{:error, NotFound.t()} when unknown id" do
      assert {:error, %NotFound{}} = Service.get_by_id(CanvasApp.UUID.generate())
    end

    test "{:ok, Canvas.t()} when known id" do
      params = %{rectangles: [@valid_rectangle_params]}
      {:ok, %{id: id} = created_canvas} = Service.create(params)

      Service.list()

      assert Service.get_by_id(id) == {:ok, created_canvas}
    end
  end

  describe "create/1" do
    test "{:ok, Canvas.t()} when params valid and insertion succeeded" do
      flood_params = %{start_coordinate: [1, 2], fill_symbol: "1"}
      params = %{
        flood: flood_params,
        rectangles: [@valid_rectangle_params]
      }

      {:ok, %Canvas{} = canvas} = Service.create(params)

      assert canvas.rectangles == [Rectangle.new(%{width: 1, height: 1, coordinates: {1, 2}, outline_symbol: "@"}) |> elem(1)]
      assert canvas.flood == Flood.new(%{fill_symbol: "1", start_coordinate: {1, 2}}) |> elem(1)
    end

    test "{:error, ValidationError.t()} when invalid params(flood format is wrong)" do
      flood_params = %{start_coordinate: [1, -3], fill_symbol: ""}

      params = %{rectangles: [@valid_rectangle_params], flood: flood_params}

      {:error, %ValidationError{reason: reason}} = Service.create(params)

      #bad to make such comparisons but for the sake of simplicity it is ok
      assert reason == "start_coordinate: x and y must not be negative, fill_symbol: must not be empty string"
    end

    test "{:error, ValidationError.t()} when invalid params(rectangle format is wrong)" do
      params = %{rectangles: [%{width: 2, height: 3, coordinates: [1, 2]}]}

      {:error, %ValidationError{reason: reason}} = Service.create(params)

      assert reason == "rectangles: At least one of :fill, :outline must be present"
    end
  end

  # maybe the most important tests

  describe "stored canvases are still drawable" do
    test "persisted fixture1" do
      params = Fixtures.params_for_fixture1_canvas()
      {:ok, canvas} = Service.create(params)

      assert Drawer.draw(canvas) == Drawer.draw(Fixtures.canvas_for_fixture1())
    end

    test "persisted fixture2" do
      params = Fixtures.params_for_fixture2_canvas()
      {:ok, canvas} = Service.create(params)

      assert Drawer.draw(canvas) == Drawer.draw(Fixtures.canvas_for_fixture2())
    end

    test "persisted fixture3" do
      params = Fixtures.params_for_fixture3_canvas()
      {:ok, canvas} = Service.create(params)

      assert Drawer.draw(canvas) == Drawer.draw(Fixtures.canvas_for_fixture3())
    end
  end
end
