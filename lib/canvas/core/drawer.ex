defmodule CanvasApp.Core.Drawer do
  alias CanvasApp.Model.{Canvas, Rectangle, Flood}

  @doc """
    applies rectangle operations to valid and successfully build canvas
    Function is pure, no exceptions or error branches considered
    rectangles rendered by their rules in predefined sequence
    after rectangles are filled we start flood if flood parameter is present on canvas.
  """
  @spec draw(Canvas.t()) :: Canvas.grid()
  def draw(canvas) do
    grid = setup_empty_grid(canvas.rectangles)

    grid_with_rectangles_painted =
      Enum.reduce(canvas.rectangles, grid, fn rectangle, grid ->
        draw_rectangle_on_grid(rectangle, grid)
      end)

    if canvas.flood do
      apply_flood(grid_with_rectangles_painted, canvas.flood)
    else
      grid_with_rectangles_painted
    end
  end

  @doc """
    using rectangles given we can calculate width and height of canvas
    using width and height we fill the grid with " " values
  """
  @spec setup_empty_grid([Rectangle.t()]) :: Canvas.grid()
  def setup_empty_grid(rectangles) do
    {width, height} = calculate_required_canvas_size_for_rectangles(rectangles)

    Enum.reduce(0..(width - 1), %{}, fn x, grid ->
      Enum.reduce(0..(height - 1), grid, fn y, grid -> Map.put(grid, {x, y}, " ") end)
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

  # Rectangle always has borders => rectangle border cell cannot be " ".
  # We traverse everywhere we can until cell != " ".
  # If flood start position is already occupied by rectangle— do nothing.
  @spec apply_flood(Canvas.grid(), Flood.t()) :: Canvas.grid()
  defp apply_flood(grid, flood) do
    symbol_at_start_position = grid[flood.start_coordinate]

    fill_cell_and_neighbours_to_the_border(grid, flood.start_coordinate, flood.fill_symbol, symbol_at_start_position)
  end

  #neighbour— cell above, on the right, on the left and at the bottom
  defp fill_cell_and_neighbours_to_the_border(grid, {curr_x, curr_y} = cell, fill_symbol, symbol_to_be_replaced) do
    grid = Map.put(grid, cell, fill_symbol)
    top_cell = {curr_x, curr_y + 1}
    left_cell = {curr_x - 1, curr_y}
    right_cell = {curr_x + 1, curr_y}
    bottom_cell = {curr_x, curr_y - 1}

    [top_cell, left_cell, right_cell, bottom_cell]
    |> Enum.reduce(grid, fn cell, grid ->
      if grid[cell] && grid[cell] == symbol_to_be_replaced do #nil is possible when we look out of borders
        fill_cell_and_neighbours_to_the_border(grid, cell, fill_symbol, symbol_to_be_replaced)
      else
        grid
      end
    end)
  end

  @spec filled_cell?(Canvas.grid(), Canvas.cell()) :: boolean()
  defp filled_cell?(grid, cell), do: grid[cell] != " "

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
