defmodule Steps.Reusable.GetPlainTextInput do
  def create(prompt) do
    MenuState.new(
      :get_plain_text_input,
      prompt,
      [],
      &handle_input/2
    )
  end

  @spec handle_input(String.t(), %MenuState{}) ::
          {:handled, %MenuState{}} | {:unhandled} | {:cancelled, %MenuState{}}
  def handle_input(input, state = %MenuState{}) do
    case input do
      "" ->
        # We assume empty string means 'cancel'.
        # Caller must handle.
        {:cancelled, state}

      input ->
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
