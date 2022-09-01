defmodule Steps.ProcessDataStep do
  def create() do
    MenuState.new(
      :process_data,
      "Process data. Would you like to do so now, or later?",
      [{"1", "Process now"}, {"2", "Process a custom value"}, {"3", "Cancel"}],
      &handle_input/2
    )
  end

  @spec handle_input(String.t(), %MenuState{}) :: %MenuState{}
  def handle_input(input, state = %MenuState{}) do
    case input do
      "1" ->
        # todo: Apply functional patterns here.
        # 'do_logic' functions like below will usually have some impure logic in them.
        # How do we keep that logic separate from this functional code? (Functional core/Imperative shell)

        # Do what this step needs to do.
        # Generate prefix text and return the "Start" step (with prefix text)
        result = do_process_now_logic()

        Steps.StartStep.create("Processed OK(#{result}).\n\n")

      "2" ->
        MenuState.prompt_plain_text_input(
          "Please type the custom data that you would like to process:",
          state
        )

      "3" ->
        # todo: "Cancel" seems like a common step. Can we add this logic with an import/use/require?
        Steps.StartStep.create("Fine. Taking you back to the start.\n\n")

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
