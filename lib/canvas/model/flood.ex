defmodule CanvasApp.Model.Flood do
  use TypedStruct

  alias CanvasApp.Model.Error.ValidationError

  typedstruct enforce: true do
    field :fill_symbol, String.t()
    field :start_coordinate, {non_neg_integer(), non_neg_integer()}
  end

  @spec new(map()) :: {:ok, __MODULE__.t()} | {:error, ValidationError.t()}
  def new(%{fill_symbol: fill, start_coordinate: start_coordinate}), do:
    {:ok, %__MODULE__{fill_symbol: fill, start_coordinate: start_coordinate}}
  def new(_), do: {:error, ValidationError.from_string("invalid shape of flood")}
end
