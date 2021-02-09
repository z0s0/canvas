defmodule CanvasApp.GenError do
  @moduledoc """
    generic error interface. All app domain errors conform to %struct{reason: String.t()} interface

    usage(as sum type)

    defmodule MyDomainErrorOne, do: use(GenError)
    defmodule MyDomainErrorTwo, do: use(GenError)

    defmodule MyDomain.Error do
      @type t() :: MyDomainErrorOne.t() | MyDomainErrorTwo.t()
    end
  """

  defmacro __using__(_) do
    quote do
      use TypedStruct

      typedstruct do
        field(:reason, String.t())
      end

      def from_string(reason) when is_binary(reason), do: %__MODULE__{reason: reason}
      def from_string(_), do: %__MODULE__{}
    end
  end
end
