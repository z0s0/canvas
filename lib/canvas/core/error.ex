defmodule CanvasApp.Core.Error do
  @type t() :: __MODULE__.DrawingError.t()

  alias CanvasApp.GenError

  defmodule DrawingError, do: use(GenError)
end