defmodule CanvasApp.MatrixTest do
  use ExUnit.Case

  alias CanvasApp.Matrix

  describe "to_list_of_lists/1" do
    test "converts flat matrix to list of lists" do
      matrix = %{
        {0, 0} => 1,
        {1, 0} => 2,
        {2, 0} => 3,
        {0, 1} => 4,
        {1, 1} => 5,
        {2, 1} => 6,
        {0, 2} => 7,
        {1, 2} => 8,
        {2, 2} => 9
      }

      result = Matrix.to_list_of_lists(matrix)
      assert result == [
               [1,2,3],
               [4,5,6],
               [7,8,9]
             ]
    end
  end
end
