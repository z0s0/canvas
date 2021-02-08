defmodule CanvasApp.Model.Canvas do
  use TypedStruct

  @type grid() :: %{{x :: non_neg_integer(), y :: non_neg_integer()} => String.t()}

  alias CanvasApp.UUID
  alias CanvasApp.Model.{Rectangle, Error}

  typedstruct enforce: true do
    field :id, UUID.t()
    field :rectangles, [Rectangle.t()], default: []
  end

  @spec new(%{required(:rectangles) => [map()]}) :: {:ok, __MODULE__.t()} | {:error, Error.ValidationError.t()}
  def new(%{rectangles: [_ | _] = rectangles}) do
    constructed_rectangles = Enum.map(rectangles, &Rectangle.new/1)

    if Enum.all?(constructed_rectangles, & match?({:ok, _}, &1)) do
      {:ok, %__MODULE__{id: UUID.generate(), rectangles: rectangles}}
    else
      # do not lose errors
      errors =
        constructed_rectangles
        |> Enum.filter(& match?({:error, _}, &1))
        |> Enum.map(& elem(&1, 1).reason)
        |> Enum.join(", ")

      {:error, Error.ValidationError.from_string(errors)}
    end
  end
  def new(_), do: {:error, Error.ValidationError.from_string("invalid shape of params")}
end