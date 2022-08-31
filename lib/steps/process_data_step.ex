defmodule Steps.ProcessDataStep do
  def create() do
    MenuState.new(
      :process_data,
      "Process data. Would you like to do so now, or later?",
      [{"1", "Process now"}, {"2", "Process later"}, {"3", "Cancel"}],
      &handle_input/2
    )
  end

  @spec handle_input(String.t(), %MenuState{}) :: %MenuState{}
  def handle_input(input, state = %MenuState{}) do
    case input do
      "1" ->
        # todo: Apply functional patterns here.
        # 'do_logic' functions like below will usually have some impure logic in them.

        # Do what this step needs to do.
        # Generate prefix text and return the "Start" step (with prefix text)
        result = do_process_now_logic()

        Steps.StartStep.create("Processed OK(#{result}).\n\n")

      "2" ->
        raise "not implemented yet"

      _str ->
        # todo - Can we make this reusable somehow?
        MenuState.reprompt_on_invalid_input(
          "Sorry, I don't recognize that option. Choose from these please:",
          state
        )
    end
  end

  defp do_process_now_logic() do
    111
  end
end
