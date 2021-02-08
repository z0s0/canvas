defmodule CanvasApp.Model.Rectangle do
  use TypedStruct

  alias CanvasApp.Model.Error

  typedstruct enforce: true do
    field :width, pos_integer()
    field :height, pos_integer()
    field :coordinates, {non_neg_integer(), non_neg_integer()}
    field :fill, String.t(), enforce: false
    field :outline, String.t(), enforce: false
  end

  #constructor can fail because of validation
  @spec new(map()) :: {:ok, __MODULE__.t()} | {:error, Error.ValidationError.t()}
  def new(%{width: width, height: height, coordinates: coords} = params) do
    [fill, outline] = [Map.get(params, :fill), Map.get(params, :outline)]

    if fill || outline do
      {:ok, %__MODULE__{
        width: width,
        height: height,
        coordinates: coords,
        fill: fill || " ", # empty fill means empty space
        outline: outline || fill # empty outline becomes fill
      }}
    else
      err = "At least one of :fill, :outline must be present"
      {:error, Error.ValidationError.from_string(err)}
    end
  end
  def new(_), do: {:error, Error.ValidationError.from_string("invalid shape of params")}
end