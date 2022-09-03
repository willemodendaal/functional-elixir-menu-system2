defmodule MyMenu do
  @moduledoc """
  The goal with this module is to keep it purely functional.
  But with state-machine-like logic (except the state always gets passed in and out)

  Caller calls `start`, and gets a `MenuState` back.
  The menuState contains text and choices that the caller can render.

  To proceed the caller gets user input (eg from the cli, or chat), and
  passed the user input in along with the menuState to get back
  new menuState.
  """

  @spec start() :: %MenuState{}
  def start() do
    Steps.StartStep.create()
  end

  # User input.
  @spec input(%MenuState{}, String.t()) :: %MenuState{}
  def input(%MenuState{handler_func: nil}, _user_input) do
    MenuState.new(:conversation_ended_already, "I've got nothing more to say to you.", [], nil)
  end

  def input(%MenuState{} = state, user_input) do
    # Principle - pass behavior as a function.
    case state.handler_func.(user_input, state) do
      {:handled, new_state} ->
        # The step handled the input.
        new_state

      {:unhandled} ->
        # The step didn't recognize the input. Prompt again.
        MenuState.reprompt_on_invalid_input(
          "Sorry, I don't recognize that option. Choose from these please:",
          state
        )
    end
  end
end
