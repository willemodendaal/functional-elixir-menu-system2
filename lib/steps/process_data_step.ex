defmodule Steps.ProcessDataStep do
  def create(prefix_text \\ "") do
    MenuState.new(
      :process_data,
      prefix_text <>
        "Process data. Would you like to process the default value, or a custom value?",
      [{"1", "Process now"}, {"2", "Process a custom value"}, {"3", "Cancel"}],
      &handle_input/2
    )
  end

  @spec handle_input(String.t(), %MenuState{}) :: {:handled, %MenuState{}} | {:unhandled}
  def handle_input(input, state = %MenuState{}) do
    case handle(input, state) do
      nil -> {:unhandled}
      state -> {:handled, state}
    end
  end

  @spec handle(String.t(), %MenuState{}) :: %MenuState{} | nil
  defp handle(input, _state = %MenuState{}) do
    case input do
      "1" ->
        # todo: Apply functional patterns here.
        # 'do_logic' functions like below will usually have some impure logic in them.
        # How do we keep that logic separate from this functional code? (Functional core/Imperative shell)

        # Do what this step needs to do.
        # Generate prefix text and return the "Start" step (with prefix text)
        result = do_process_now_logic(111)

        Steps.StartStep.create("Processed OK(#{result}).\n\n")

      "2" ->
        MenuState.new(
          :process_data_custom_data_entry,
          "Please type the custom data that you would like to process:",
          [],
          &handle_custom_data_text/2
        )

      "3" ->
        # todo: "Cancel" seems like a common step. Can we add this logic with an import/use/require?
        Steps.StartStep.create("Fine. Taking you back to the start.\n\n")

      _ ->
        # We don't know how to handle this.
        nil
    end
  end

  @spec handle_custom_data_text(String.t(), %MenuState{}) ::
          {:handled, %MenuState{}} | {:unhandled}
  def handle_custom_data_text(custom_text_input, _state) do
    # todo: Consider how we can enhance plain text input to allow:
    # - validation
    # - cancelling

    case custom_text_input do
      "" ->
        {:handled, Steps.ProcessDataStep.create("Cancelled.\n\n")}

      custom_text_input ->
        # Process, show success, and prompt again at the **Process menu**.
        result = do_process_now_logic(custom_text_input)
        {:handled, Steps.ProcessDataStep.create("Processed OK(#{result}).\n\n")}
    end
  end

  defp do_process_now_logic(data_to_process) do
    # todo: Consider what to do with IO and 'side effect' logic here.
    # Custom data will likely go to a database.
    data_to_process
  end
end
