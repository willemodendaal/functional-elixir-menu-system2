defmodule MenuState do
  defstruct [:step, :text, :choices, :data]

  def new(step, text, choices, data) when is_binary(text) do
    %MenuState{step: step, text: text, choices: choices, data: data}
  end

  def quit(text) when is_binary(text) do
    MenuState.new(:quit, text, [], nil)
  end

  def reprompt_on_invalid_input(reprompt_text, previous_state = %MenuState{}) do
    MenuState.new(previous_state.step, reprompt_text, previous_state.choices, previous_state.data)
  end
end
