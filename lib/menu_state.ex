defmodule MenuState do
  defstruct [:step, :text, :choices, :handler_func]

  def new(step, text, choices, nil) when is_binary(text) do
    %MenuState{step: step, text: text, choices: choices, handler_func: nil}
  end

  def new(step, text, choices, handler_func)
      when is_binary(text) and is_function(handler_func, 2) do
    %MenuState{step: step, text: text, choices: choices, handler_func: handler_func}
  end

  def quit(text) when is_binary(text) do
    MenuState.new(:quit, text, [], nil)
  end

  def reprompt_on_invalid_input(reprompt_text, previous_state = %MenuState{}) do
    MenuState.new(
      previous_state.step,
      reprompt_text,
      previous_state.choices,
      previous_state.handler_func
    )
  end

  def prompt_plain_text_input(prompt_text, previous_state = %MenuState{}) do
    MenuState.new(
      previous_state.step,
      prompt_text,
      [],
      previous_state.handler_func
    )
  end
end
