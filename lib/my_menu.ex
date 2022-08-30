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
  @spec input(String.t(), %MenuState{}) :: %MenuState{}
  def input(_user_input, %MenuState{handler: nil}) do
    MenuState.new(:conversation_ended_already, "I've got nothing more to say to you.", [], nil)
  end

  def input(user_input, %MenuState{} = state) do
    # Principle - pass behavior as a function (here encapsulated in state.handler)
    state.handler.handle_input(user_input, state)
  end
end
