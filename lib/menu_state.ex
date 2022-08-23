defmodule MenuState do
  defstruct [:prompt, :state]

  def new(prompt, state) when is_binary(prompt) do
    %MenuState{prompt: prompt, state: state}
  end
end
