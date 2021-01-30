defmodule CanvasApp.GenError do
  defmacro __using__(_) do
    quote do
      use TypedStruct

      typedstruct do
        field :message, String.t()
      end

      def from_string(reason) when is_binary(reason), do: %__MODULE__{reason: reason}
      def from_string(_), do: %__MODULE__{}
    end
  end
end