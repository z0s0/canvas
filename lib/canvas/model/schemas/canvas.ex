defmodule CanvasApp.Model.Schemas.Canvas do
  @moduledoc """
    Canvas presentation in database. raw data representations are a little bit simpler than embedded_schemas.
    As we do not use Ecto.Schemas as domain objects(we immediately cast schemas to generic objects) we do not need embedded_schemas.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "canvases" do
    field :rectangles, {:array, :map}
    field :flood, :map

    timestamps()
  end

  @required_attrs [:rectangles, :id]

  def changeset(canvas, params) do
    canvas
    |> cast(params, [:flood | @required_attrs])
    |> validate_required(@required_attrs)
    |> validate_rectangles()
    |> validate_flood()
  end

  defp validate_rectangles(changeset) do
    alias CanvasApp.Model.Rectangle

    rectangles =
      changeset
      |> get_field(:rectangles)
      |> Enum.map(&Rectangle.new/1)

    if Enum.all?(rectangles, & match?({:ok, _}, &1)) do
      changeset
    else
       first_error = Enum.find(rectangles, & match?({:error, _}, &1)) |> elem(1)
       add_error(changeset, :rectangles, first_error.reason)
    end



  end

  defp validate_flood(changeset) do
    flood = get_field(changeset, :flood)
    if is_nil(flood) do
      changeset
    else
      fill_symbol = flood.fill_symbol

      changeset = if fill_symbol == "" do
        add_error(changeset, :fill_symbol, "must not be empty string")
      else
        changeset
      end

      if valid_coordinates?(flood.start_coordinate) do
        changeset
      else
        add_error(changeset, :start_coordinate, "x and y must not be negative")
      end
    end
  end

  defp valid_coordinates?([x, y]), do: x >= 0 && y >= 0
end
