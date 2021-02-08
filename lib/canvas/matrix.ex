defmodule CanvasApp.Matrix do
  @moduledoc """
    Flat structure for matrix is a design decision. Problem— unreadable => hard to debug.
    Matrix representation:

    [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]— very readable, but very inefficient.

    We represent such matrix as

    %{
       {0,0} => 1,
       {0, 1} => 2,
       {0, 2} => 3,
       {1,0} => 4,
       {1, 1} => 5,
       {1, 2} => 6,
       {2, 0} => 7,
       {2, 1} => 8,
       {2, 2} => 9
    }— effecient on reads and updates but hard to read and debug.

    This module contains helpers for dealing with such formats.
  """

  @doc """
    Very inefficient but very illustrative method. Do not use in production code but feel free to use while debugging
  """
  def to_list_of_lists(flat_matrix) do
    {{width, _}, _} = Enum.max_by(flat_matrix, fn {{x, _}, _} -> x end)
    {{_, height}, _} = Enum.max_by(flat_matrix, fn {{_, y}, _} -> y end)

    list_of_lists = List.duplicate(List.duplicate(nil, width + 1), height + 1)

    Enum.reduce(flat_matrix, list_of_lists, fn {{x, y}, val}, acc ->
      updated_row = Enum.at(acc, y) |> List.replace_at(x, val)
      List.replace_at(acc, y, updated_row)
    end)
  end
end