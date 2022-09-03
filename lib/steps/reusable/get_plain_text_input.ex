defmodule Steps.Reusable.GetPlainTextInput do
  def create(prompt, callback_handler) when is_function(callback_handler) do
    MenuState.new(
      :get_plain_text_input,
      prompt,
      [],
      fn input, _state ->
        handle_custom_data_text(input, callback_handler)
      end
    )
  end

  @spec handle_custom_data_text(String.t(), fun()) :: %MenuState{}
  def handle_custom_data_text(custom_text_input, callback_handler) do
    # todo: Consider how we can enhance plain text input to allow:
    # - validation
    # - cancelling

    case custom_text_input do
      "" ->
        callback_handler(MenuState.new(1111)

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
