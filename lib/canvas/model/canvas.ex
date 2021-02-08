defmodule CanvasApp.Model.Canvas do
  use TypedStruct

  @type cell() :: {x :: non_neg_integer(), y :: non_neg_integer()}
  @type grid() :: %{cell() => String.t()}

  alias CanvasApp.UUID
  alias CanvasApp.Model.{Rectangle, Error.ValidationError, Flood}

  typedstruct enforce: true do
    field :id, UUID.t()
    field :rectangles, [Rectangle.t()]
    field :flood, Flood.t(), enforce: false
  end

  @spec new(%{required(:rectangles) => [map()]}) :: {:ok, __MODULE__.t()} | {:error, ValidationError.t()}
  def new(%{rectangles: [_ | _] = rectangles} = params) do
    constructed_rectangles = Enum.map(rectangles, &Rectangle.new/1)

    if Enum.all?(constructed_rectangles, & match?({:ok, _}, &1)) do
      flood_params = Map.get(params, :flood)

      if flood_params do
        case Flood.new(flood_params) do
          {:ok, flood} ->
            {:ok, %__MODULE__{id: UUID.generate(), rectangles: rectangles, flood: flood}}

            {:error, %{reason: _}} = err -> err
        end
      else
        {:ok, %__MODULE__{id: UUID.generate(), rectangles: rectangles}}
      end
    else
      # do not lose errors
      errors =
        constructed_rectangles
        |> Enum.filter(& match?({:error, _}, &1))
        |> Enum.map(& elem(&1, 1).reason)
        |> Enum.join(", ")

      {:error, ValidationError.from_string(errors)}
    end
  end
  def new(_), do: {:error, ValidationError.from_string("invalid shape of params")}
end
