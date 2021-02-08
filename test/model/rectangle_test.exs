defmodule CanvasApp.Model.RectangleTest do
  use ExUnit.Case

  alias CanvasApp.Model.{Rectangle, Error.ValidationError}

  describe "new/1" do
    test "returns {:ok, %Rectangle{} if params are valid" do
      params = %{width: 5, height: 3, coordinates: {1, 1}, fill_symbol: "|", outline_symbol: "@"}
      assert {:ok, %Rectangle{}} = Rectangle.new(params)
    end

    test "returns {:error, Error.ValidationError.t()} when no outline and fill provided" do
      params = %{width: 5, height: 3, coordinates: {0,0}}
      assert {:error, %ValidationError{}} = Rectangle.new(params)
    end

    test "returns {:error, Error.ValidationError.t()} when wrong params format provided" do
      params = %{something: "???"}

      assert {:error, _} = Rectangle.new(params)
    end
  end
end
