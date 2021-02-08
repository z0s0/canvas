defmodule CanvasApp.Model.Rectangle do
  use TypedStruct

  alias CanvasApp.Model.Error

  typedstruct enforce: true do
    field :width, pos_integer()
    field :height, pos_integer()
    field :coordinates, {non_neg_integer(), non_neg_integer()}
    field :fill_symbol, String.t(), enforce: false
    field :outline_symbol, String.t(), enforce: false
  end

  #constructor can fail because of validation
  @spec new(map()) :: {:ok, __MODULE__.t()} | {:error, Error.ValidationError.t()}
  def new(%{width: width, height: height, coordinates: coords} = params) do
    [fill, outline] = [Map.get(params, :fill_symbol), Map.get(params, :outline_symbol)]

    if fill || outline do
      {:ok, %__MODULE__{
        width: width,
        height: height,
        coordinates: coords,
        fill_symbol: fill || " ", # empty fill means empty space
        outline_symbol: outline || fill # empty outline becomes fill
      }}
    else
      err = "At least one of :fill, :outline must be present"
      {:error, Error.ValidationError.from_string(err)}
    end
  end
  def new(_), do: {:error, Error.ValidationError.from_string("invalid shape of params")}
end
