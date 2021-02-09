defmodule CanvasApp.UUID do
  @type t() :: String.t()

  @spec generate() :: CanvasApp.UUID.t()
  def generate(), do: UUID.uuid4()
end
