defmodule MyMenu do
  @moduledoc """
  The goal with this module is to keep it purely functional.
  But with state-machine-like logic (except the state always gets passed in and out)
  """

  def start() do
    Steps.StartStep.create(nil)
  end

  # User input.
  @spec input(String.t(), %MenuState{}) :: %MenuState{}
  def input(str, %MenuState{} = state) do
    handle_input(state.step, str, state)
  end

  @spec handle_input(any, String.t(), %MenuState{}) :: %MenuState{}
  defp handle_input(:start, str, state = %MenuState{}) do
    case str do
      "q" ->
        MenuState.quit("Thanks, see you next time :)")

      "1" ->
        MenuState.new(
          :process_data,
          "Process data. Would you like to do so now, or later?",
          [{"1", "Process now"}, {"2", "Process later"}, {"3", "Cancel"}],
          state.data
        )

      _str ->
        MenuState.reprompt_on_invalid_input(
          "Sorry, I don't recognize that option. Choose from these please:",
          state
        )
    end
  end

  defp handle_input(:process_data, str, state = %MenuState{}) do
    raise "not handled yet"
  end
end
