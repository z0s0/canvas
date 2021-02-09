defmodule CanvasApp.Core.CanvasContext do
  @moduledoc """
    business logic layer. Repo and Cache allowed as dependencies(db layer and cache layer)
    exposes domain objects not ecto schemas.

    Basically we consider Canvases and Rectangles stored in database valid because they have already passed validations during insertion
    So that error branches of Canvas.new/1 and Rectangle.new/1 are not considered
  """

  alias CanvasApp.{UUID, Repo, Model, Core.Error}
  alias Model.{Canvas, Schemas, Rectangle, Flood}
  alias Schemas.Canvas, as: CanvasSchema

  @dialyzer {:nowarn_function, canvas_schema_to_canvas: 1}

  @spec list() :: [Canvas.t()]
  def list(), do: CanvasSchema |> Repo.all() |> Enum.map(&canvas_schema_to_canvas/1)

  @spec get_by_id(UUID.t()) :: {:ok, Canvas.t()} | {:error, Error.NotFound.t()}
  def get_by_id(canvas_id) do
    case Repo.get(CanvasSchema, canvas_id) do
      nil ->
        msg = "CanvasSchema with id #{canvas_id} not found"
        {:error, Error.NotFound.from_string(msg)}

      canvas_schema ->
        {:ok, canvas_schema_to_canvas(canvas_schema)}
    end
  end

  @spec create(map()) :: {:ok, Canvas.t()} | {:error, Error.t()}
  def create(canvas_params) do
    %CanvasSchema{}
    |> CanvasSchema.changeset(Map.put(canvas_params, :id, UUID.generate()))
    |> Repo.insert()
    |> case do
      {:ok, schema} ->
        {:ok, canvas_schema_to_canvas(schema)}

      {:error, changeset} ->
        err = changeset_errors_to_string(changeset.errors)
        {:error, Error.ValidationError.from_string(err)}
    end
  end

  @spec canvas_schema_to_canvas(%{required(:rectangles) => [map()]}) :: Canvas.t()
  defp canvas_schema_to_canvas(%{flood: flood, rectangles: rectangles, id: id}) do
    domain_rectangles = Enum.map(rectangles, &rectangle_from_dump/1)

    {:ok, canvas} = Canvas.new(%{flood: flood_from_dump(flood), rectangles: domain_rectangles})

    Map.put(canvas, :id, id)
  end

  # seems like all rectangles stored in database are valid(validations on create prevent wrong shapes)
  # so that we can skip error branch of Rectangle.new/1
  @spec rectangle_from_dump(map()) :: Rectangle.t()
  defp rectangle_from_dump(
         %{
           "coordinates" => [x, y],
           "height" => height,
           "width" => width
         } = dump
       ) do
    {:ok, rectangle} =
      Rectangle.new(%{
        width: width,
        height: height,
        coordinates: {x, y},
        outline_symbol: dump["outline_symbol"],
        fill_symbol: dump["fill_symbol"]
      })

    rectangle
  end

  defp rectangle_from_dump(
         %{
           width: width,
           height: height,
           coordinates: [x, y]
         } = dump
       ) do
    {:ok, rectangle} =
      Rectangle.new(%{
        width: width,
        height: height,
        coordinates: {x, y},
        outline_symbol: dump[:outline_symbol],
        fill_symbol: dump[:fill_symbol]
      })

    rectangle
  end

  @spec flood_from_dump(map() | nil) :: Flood.t() | nil
  defp flood_from_dump(nil), do: nil

  defp flood_from_dump(%{fill_symbol: fill_sym, start_coordinate: [x, y]}) do
    {:ok, flood} = Flood.new(%{fill_symbol: fill_sym, start_coordinate: {x, y}})

    flood
  end

  defp flood_from_dump(%{"fill_symbol" => fill_sym, "start_coordinate" => [x, y]}) do
    {:ok, flood} = Flood.new(%{fill_symbol: fill_sym, start_coordinate: {x, y}})

    flood
  end

  defp changeset_errors_to_string(errors) do
    errors
    |> Enum.map(fn {field, {msg, _}} -> "#{field}: #{msg}" end)
    |> Enum.join(", ")
  end
end
