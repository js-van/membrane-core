defmodule Membrane.Element.CallbackContext.PadRemoved do
  @moduledoc """
  Structure representing a context that is passed to the element when
  when new pad added is created
  """
  @behaviour Membrane.Element.CallbackContext

  @type t :: %Membrane.Element.CallbackContext.PadRemoved{
          playback_state: Membrane.Core.Playback.state_t(),
          direction: :sink | :source,
          caps: Membrane.Caps.t()
        }

  defstruct playback_state: nil,
            direction: nil,
            caps: nil

  @impl true
  defmacro from_state(state, entries) do
    quote do
      %unquote(__MODULE__){
        unquote_splicing(entries),
        playback_state: unquote(state).playback.state
      }
    end
  end
end
