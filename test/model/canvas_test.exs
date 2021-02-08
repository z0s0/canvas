defmodule CanvasApp.Model.CanvasTest do
  use ExUnit.Case

  alias CanvasApp.Model.{Canvas, Error.ValidationError, RectangleFactory}

  describe "new/1" do
    test "returns {:ok, %Canvas{}} when params are valid" do
      params = %{rectangles: [RectangleFactory.build(), RectangleFactory.build()]}
      assert {:ok, %Canvas{id: _, rectangles: _}} = Canvas.new(params)
    end

    test "returns {:error, Error.ValidationError.t()} when one of rectangles is invalid" do
      # and saves all validation errors
      invalid_rectangle_params2 = %{width: 1}
      invalid_rectangle_params1 = %{width: 1, height: 1, coordinates: {1, 1}}
      params = %{rectangles: [RectangleFactory.build(), invalid_rectangle_params1, invalid_rectangle_params2]}
      {:error, %ValidationError{} = e} = Canvas.new(params)

      assert e.reason == "At least one of :fill, :outline must be present, invalid shape of params" #both reasons
    end

    test "returns {:error, Error.ValidationError.t()} when no rectangles provided" do
      params = %{rectangles: []}
      assert {:error, _} = Canvas.new(params)
    end
  end
end
