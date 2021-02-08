defmodule CanvasApp.Core.Error do
  @type t() :: __MODULE__.DrawingError.t() |
               __MODULE__.NotFound.t() |
               __MODULE__.ValidationError.t()

  alias CanvasApp.GenError

  defmodule DrawingError, do: use(GenError)
  defmodule NotFound, do: use(GenError)
  defmodule ValidationError, do: use(GenError)
end
