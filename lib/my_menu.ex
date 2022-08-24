defmodule MyMenu do
  @moduledoc """
  The goal with this module is to keep it purely functional.
  But with state-machine-like logic (except the state always gets passed in and out)
  """

  @spec start() :: %MenuState{}
  def start() do
    Steps.StartStep.create()
  end

  # User input.
  @spec input(String.t(), %MenuState{}) :: %MenuState{}
  def input(user_input, %MenuState{} = state) do
    state.handler.handle_input(user_input, state)
  end
end
