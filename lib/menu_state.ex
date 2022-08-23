defmodule MenuState do
  defstruct [:text, :choices, :state]

  def new(text, choices, state) when is_binary(text) do
    %MenuState{text: text, choices: choices, state: state}
  end

  def quit(text) when is_binary(text) do
    %MenuState{text: text, choices: [], state: nil}
  end
end
