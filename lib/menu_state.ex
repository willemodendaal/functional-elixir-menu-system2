defmodule MenuState do
  defstruct [:step, :text, :choices, :handler]

  def new(step, text, choices, handler) when is_binary(text) and is_atom(handler) do
    %MenuState{step: step, text: text, choices: choices, handler: handler}
  end

  def quit(text) when is_binary(text) do
    MenuState.new(:quit, text, [], nil)
  end

  def reprompt_on_invalid_input(reprompt_text, previous_state = %MenuState{}) do
    MenuState.new(
      previous_state.step,
      reprompt_text,
      previous_state.choices,
      previous_state.handler
    )
  end
end
