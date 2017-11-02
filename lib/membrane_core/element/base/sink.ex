defmodule Membrane.Element.Base.Sink do

  defmacro __using__(_) do
    quote location: :keep do
      use Membrane.Element.Base.Mixin.CommonBehaviour
      use Membrane.Element.Base.Mixin.SinkBehaviour


      @doc """
      Returns module that manages this element.
      """
      @spec manager_module() :: module
      def manager_module, do: Membrane.Element.Manager.Sink


      # Default implementations

      @doc false
      def handle_new_pad(_pad, _context, state), do: {:error, :adding_pad_unsupported}

      @doc false
      def handle_pad_added(_pad, _context, state), do: {:ok, state}

      @doc false
      def handle_pad_removed(_pad, _context, state), do: {:ok, state}

      @doc false
      def handle_caps(_pad, _caps, _context, state), do: {:ok, state}

      @doc false
      def handle_event(_pad, _event, _context, state), do: {:ok, state}

      @doc false
      def handle_single_write(_pad, _buffer, _context, state), do: {:ok, state}

      @doc false
      def handle_write(pad, buffers, context, state) do
        buffers |> Membrane.Element.Manager.Common.reduce_something1_results(state, fn buf, st ->
            handle_single_write pad, buf, context, st
          end)
      end


      defoverridable [
        handle_new_pad: 3,
        handle_pad_added: 3,
        handle_pad_removed: 3,
        handle_caps: 4,
        handle_event: 4,
        handle_write: 4,
        handle_single_write: 4,
      ]
    end
  end
end
