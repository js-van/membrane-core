defmodule Membrane.Element.Base.Source do

  defmacro __using__(_) do
    quote location: :keep do
      use Membrane.Element.Base.Mixin.CommonBehaviour
      use Membrane.Element.Base.Mixin.SourceBehaviour


      @doc """
      Returns module that manages this element.
      """
      @spec manager_module() :: module
      def manager_module, do: Membrane.Element.Manager.Source


      # Default implementations

      @doc false
      def handle_new_pad(_pad, _context, state), do: {:error, :adding_pad_unsupported}

      @doc false
      def handle_pad_added(_pad, _context, state), do: {:ok, state}

      @doc false
      def handle_pad_removed(_pad, _context, state), do: {:ok, state}

      @doc false
      def handle_single_demand(_pad, _context, state), do:
        {{:error, :handle_demand_not_implemented}, state}

      @doc false
      def handle_demand(pad, size, :buffers, context, state) do
        1..size |> Membrane.Element.Manager.Common.reduce_something1_results(state, fn _, st ->
            handle_single_demand pad, context, st
          end)
      end
      def handle_demand(_pad, _size, _unit, _context, state), do:
        {{:error, :handle_demand_not_implemented}, state}

      @doc false
      def handle_event(_pad, _event, _context, state), do: {:ok, state}


      defoverridable [
        handle_new_pad: 3,
        handle_pad_added: 3,
        handle_pad_removed: 3,
        handle_single_demand: 3,
        handle_demand: 5,
        handle_event: 4,
      ]
    end
  end
end
