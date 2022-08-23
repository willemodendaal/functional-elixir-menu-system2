defmodule MenuState do
  defstruct [:text, :choices, :data]

  def new(text, choices, data) when is_binary(text) do
    %MenuState{text: text, choices: choices, data: data}
  end

  def quit(text) when is_binary(text) do
    MenuState.new(text, [], nil)
  end

  def reprompt_on_invalid_input(reprompt_text, previous_state = %MenuState{}) do
    MenuState.new(reprompt_text, previous_state.choices, previous_state.data)
  end
end
