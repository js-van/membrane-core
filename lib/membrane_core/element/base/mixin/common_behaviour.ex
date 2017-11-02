defmodule Membrane.Element.Base.Mixin.CommonBehaviour do

  @callback is_membrane_element :: true

  @callback manager_module :: module

  @callback handle_init(Membrane.Element.element_options_t) ::
    {:ok, any} |
    {:error, any}

  @callback handle_shutdown(any) :: any

  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Membrane.Element.Base.Mixin.CommonBehaviour

      use Membrane.Mixins.Log, tags: :element, import: false

      # Default implementations

      @doc """
      Enables to check whether module is membrane element
      """
      def is_membrane_element, do: true

      @doc false
      def handle_init(_options), do: {:ok, %{}}

      @doc false
      def handle_prepare(_previous_playback_state, _context, state), do: {:ok, state}

      @doc false
      def handle_play(_context, state), do: {:ok, state}

      @doc false
      def handle_stop(_context, state), do: {:ok, state}

      @doc false
      def handle_other(_message, _context, state), do: {:ok, state}

      @doc false
      def handle_shutdown(_context, _state), do: :ok


      defoverridable [
        handle_init: 1,
        handle_prepare: 3,
        handle_play: 2,
        handle_stop: 2,
        handle_other: 3,
        handle_shutdown: 2,
      ]
    end
  end
end
