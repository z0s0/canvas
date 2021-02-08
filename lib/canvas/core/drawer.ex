defmodule CanvasApp.Core.Drawer do
  alias CanvasApp.Core.Error
  alias CanvasApp.Model.Canvas

  @spec draw(Canvas.t()) :: {:ok, map()} | {:error, Core.Error.t()}
  def draw(canvas) do
    grid = setup_empty_grid(canvas.rectangles)

    grid_with_rectangles_painted =
      Enum.reduce(canvas.rectangles, grid, fn rectangle, grid ->
        draw_rectangle_on_grid(rectangle, grid)
      end)

    if canvas.flood_symbol do
      apply_flood(grid_with_rectangles_painted, canvas.flood_symbol)
    else
      grid_with_rectangles_painted
    end
  end

  @doc """
    using rectangles given we can calculate width and height of canvas
    it will look nicer if we add 3-4 additional cells
    using width and height we fill the grid with "" values
  """
  @spec setup_empty_grid([Rectangle.t()]) :: Canvas.grid()
  def setup_empty_grid(rectangles) do
    {width, height} = calculate_required_canvas_size_for_rectangles(rectangles)

    Enum.reduce(0..width, %{}, fn x, grid ->
      Enum.reduce(0..height, grid, fn y, grid -> Map.put(grid, {x, y}, " ") end)
    end)
  end

  @spec draw_rectangle_on_grid(Rectangle.t(), Canvas.grid()) :: Canvas.grid()
  def draw_rectangle_on_grid(rectangle, initial_grid) do
    {start_x, start_y} = rectangle.coordinates

    Enum.reduce(start_x..(start_x + rectangle.width - 1), initial_grid, fn x, grid ->
      Enum.reduce(start_y..(start_y + rectangle.height - 1), grid, fn y, grid ->
        curr_cell = {x,y}
        fill_symbol =
          if edge_cell?(curr_cell, rectangle) && rectangle.outline_symbol do
            rectangle.outline_symbol
          else
            rectangle.fill_symbol
          end

        %{grid | curr_cell => fill_symbol}
      end)
    end)

  end

  defp apply_flood(grid, canvas) do

  end

  defp edge_cell?({x,y} = _cell, rectangle) do
    {start_x, start_y} = rectangle.coordinates

    x == start_x ||
      x == (start_x + rectangle.width - 1) ||
    y == start_y ||
      y == (start_y + rectangle.height - 1)
  end

  defp calculate_required_canvas_size_for_rectangles(rectangles) do
    Enum.reduce(rectangles, {0, 0}, fn rectangle, {width_required, height_required} ->
      coordinates = rectangle.coordinates
      width_required_for_rectangle = rectangle.width + elem(coordinates, 0)
      height_required_for_rectangle = rectangle.height + elem(coordinates, 1)

      {max(width_required, width_required_for_rectangle), max(height_required, height_required_for_rectangle)}
    end)
  end
end
