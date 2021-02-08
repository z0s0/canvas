defmodule CanvasApp.Model.Error do
  @type t() :: __MODULE__.ValidationError.t()

  defmodule ValidationError, do: use(CanvasApp.GenError)
end